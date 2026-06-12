Return-Path: <netdev+bounces-298730-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id spdCCG03LGptNwQAu9opvQ
	(envelope-from <netdev+bounces-298730-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 18:44:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 851E267B09E
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 18:44:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=g28IQpxO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298730-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298730-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C3D093000529
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 16:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A846A374A1B;
	Fri, 12 Jun 2026 16:41:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B719382F10
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 16:41:22 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781282483; cv=pass; b=PLGfOAQILYFCJ6P1UOg64HPKQytei90rk5HdwknDuFExQq1PRIMSKEOj7t2lFyNQx1foKQKndQx0kSBJq5dDt8gPN8vtJcZj9W7Q0Hwrx+V5qXnhgsIIpxxT4dmVC163JCrOmNlge/6hjdsj12UmRYt5XDJUotiCGp0hGmQxick=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781282483; c=relaxed/simple;
	bh=BP/TEU1aUp3Lzha4y1GO32SmQVJK1HGsyxY9Bia1i1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z4A1Yz8Knw8JOs/ABGvHjith8m+kNcTIE7gQKTwb8YuDsrhz4ba98MtkwO4y8w0j/Rjzb+saW9LFFH2ltBCPzHmoupBuyTg0gNtZfpbUoTkXxg+kheSL3VY+H1LQu/GfogA05VQdpLCw3w1WtpnHpKseixTmr2RHC791xxZN784=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g28IQpxO; arc=pass smtp.client-ip=209.85.160.173
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5177d1ff061so557871cf.1
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 09:41:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781282481; cv=none;
        d=google.com; s=arc-20240605;
        b=hj2NCcCl/NDmRv8dgqp6P/Qk9MydXIm4H9P0voxG1FVQfBqrj6PQXw9YmmUHDjgyeY
         bqwK65IPfwDz+iRSJxAed5mjh5V2YQlXHXYToL82qdTrh5Gzi+pVXSlhLdDtXFi+Vh37
         rFDgJnVXuBIUZ7Cav+AG2nWcex5HBz2qBgD1AbRj/B2PYpIRezE8BIP41a7E39A1QCFZ
         YmqvQBxsXvHMgf0doKiroGt17gIUirBgyM0I+HhCUbvVKcyfeI9yuGhmJL4HELqN49US
         XnvW9Gtmrrx88w6IG7xngNbIcvBRNgGQsTUQF3Rff4v9I/pI4E7VR3Bn8jjWE5Fa31f5
         5VZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R4sEGBFr682HVIkwOysoDKHHcczJpLA/9ZzssYkvyMU=;
        fh=Cj7FWosYNeKJdlVRscqRD+N31vylWKKvhXtu3P5Tw2s=;
        b=bpYiFVK2KDY/j9hZr3dbfhb8y32g85co5GAhMeYZrI930DTRi+2gcmFlTsHiWvF+H8
         5Pi2aPRTjzHRgU9H4rEcOQynmXtidt/8BDtp3bG8PX+BeYyfLbYav7MUUlB5wtXLrJ7S
         V49Ka0ysGfMpQnLp7jsgQS+IyfQtxj2rI5TnT5B40+vrxY5oVmNmKqLqkFhuMBHB+62l
         nQASHWc+fDiy7cN1bPMhqt+rJvNnKFbXPzLsoCHSkn2hckzkdJYwgN2gO/gE2lBDAc40
         v0k4d95K8c3jsGH605ADZEx9O6EQmgnd2zZ21iCsm4x1vhD/UAiW/YNlzbb32515o2wr
         n6dw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781282481; x=1781887281; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R4sEGBFr682HVIkwOysoDKHHcczJpLA/9ZzssYkvyMU=;
        b=g28IQpxODYnV4Xqvz9xXof7F6B/sxKnbSFPCuaEN+JpS12VziWv0PrsDfV7TpNeE50
         kOxa2Y9jmdD5WfzqxRntxXzjKjxSMT2RxQtUMuob3E2cq3fBtCIjp9Mmb+oPfkkxBYnw
         vZSe5QYHGpj7+h5a6injuczt1+2J7NuS0U5FzG+oikvAu0ZPSjxmws0Bnz+NMvKIycLG
         OiUawBVHE509z1fNul1uvmyAzgxlO53CTQwRLPUqQ39qd2fgcfcUpwkLmhHUHss4Pwr5
         1BmAbf+n1FWFLGv0CS7KKBku3g+FLa0wQwyd/NPN83aX+XY5mEy7/x8Nb3LcSFATkAX/
         R8+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781282481; x=1781887281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R4sEGBFr682HVIkwOysoDKHHcczJpLA/9ZzssYkvyMU=;
        b=Jy7ko/O0ccr+x2LIURFFslGAo73G/WFq0CDDVLaYoxw/uYL1bSsWqA4MDungSoSwP5
         r7nFH95hdUCRGGzUGadJQ0RaWMoYspbkOnzyQmZEGRLTPBHgoKsR7QMMdkvWZ10imQlq
         Bvlj2q5XojshGOAK139OJssAGK6ClkNi9wndSMeYulZBUJOMk0YYaMJ8On++m6ySesCM
         0BiIPLpMRIca1RKJX5OSoW9cYJdRyOGex2e5OdfSbeD7Q3iVwtBxUWubq1k599nOLHfo
         cGkGpm0Sq49WyY6AxuNx+GFQTs8vCH8qAsYgqCSTzQfRghFzMuq2zJ4rHgaiqvqxkPVg
         Q41g==
X-Forwarded-Encrypted: i=1; AFNElJ/hybrcaJD7+ar81s8HAdLADomLITeK/qbhGTbI/69kxk81nZsdcazdqvQlLwKfl4Q5JakJir4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/gDtgj1NdfNK9jsRwTX/EshsTBEfDeoIO/AjmOdUfZOn+ZpoE
	uF57p60KtEZFdOU/V/TzzxF+wB9/7LNPZ/9eWQOpf1Bv5+ViYHRU8Olv+PhmEjkU8rzovG0dhnu
	LA8UGxH7PpdgRuXrRblZGBkOnaEHEgzw7AwTV1xQD
X-Gm-Gg: Acq92OEk48qlicibPdwyc800xEF8c11N0WhKutXPrhyp/DlRfIIzR5oHoaZnT1iBQB8
	DmMIHt0113hI2epJQ1A6fzhSlwCwKvl2ZMpl+6+OZhoNLvbK4s0PYHkn3YBl8rHcFzZzHRc1amZ
	nc0gUoLLnhXGPgj1EeDTrVjMMCaJ0oDclmScH9UkDdoyAZ8D9gClc2zmiiRiqJtfmnN0p1+A/7T
	4V96YHebDd38w+9By7VtglZZXihZ/b4A54Q9868h7Rx+grjyHVvwYyscRWeYysG4pcxn4s6QoZv
	/BLmrA==
X-Received: by 2002:a05:622a:5906:b0:50e:38f0:ccb2 with SMTP id
 d75a77b69052e-517fc521930mr8949631cf.15.1781282480443; Fri, 12 Jun 2026
 09:41:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610230409.A44D29FA@davehans-spike.ostc.intel.com>
 <20260610230413.D68967BC@davehans-spike.ostc.intel.com> <aipphZ5iCnbXVNSR@google.com>
 <CAJuCfpHmem_g7mEoic7O56LVSLkbftgWYgzexPWy7VSwp7_SiA@mail.gmail.com>
 <131c6a49-9177-418b-a653-8f13942fb8d3@kernel.org> <876077cc-db6a-4517-9d81-cdfbb43e599e@intel.com>
In-Reply-To: <876077cc-db6a-4517-9d81-cdfbb43e599e@intel.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 12 Jun 2026 09:41:08 -0700
X-Gm-Features: AVVi8CcePaseOhbsxWf8YW1Kr17EUDVr9ZOtARek6g3IEepVDrdvgDvl_QlRRYk
Message-ID: <CAJuCfpFh60wULMkFc7hzxWNg+qmZ2R_HMw_QZe5CNcDRFuoN6A@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] binder: Make shrinker rely solely on per-VMA lock
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Carlos Llamas <cmllamas@google.com>, Christian Brauner <christian@brauner.io>, 
	David Ahern <dsahern@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org, 
	Lorenzo Stoakes <ljs@kernel.org>, netdev@vger.kernel.org, 
	Shakeel Butt <shakeel.butt@linux.dev>, Todd Kjos <tkjos@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dave.hansen@intel.com,m:vbabka@kernel.org,m:aliceryhl@google.com,m:dave.hansen@linux.intel.com,m:linux-kernel@vger.kernel.org,m:akpm@linux-foundation.org,m:arve@android.com,m:cmllamas@google.com,m:christian@brauner.io,m:dsahern@kernel.org,m:davem@davemloft.net,m:gregkh@linuxfoundation.org,m:Liam.Howlett@oracle.com,m:linux-mm@kvack.org,m:ljs@kernel.org,m:netdev@vger.kernel.org,m:shakeel.butt@linux.dev,m:tkjos@android.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[surenb@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-298730-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[surenb@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 851E267B09E

On Fri, Jun 12, 2026 at 9:05=E2=80=AFAM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 6/12/26 08:41, Vlastimil Babka (SUSE) wrote:
> >>> If the vma lookup fails because the mmap write lock is held, but the =
vma
> >>> actually exists (has not been unmapped), then this code might "succes=
sfully"
> >>> remove the page without invoking zap_vma_range(). This means that the
> >>> page does not actually get freed and will just hang around forever un=
til
> >>> the process owning the vma exits or Binder needs this page and maps a
> >>> new page on top of the page.
> >> Yeah, I think if lock_vma_under_rcu() returns NULL you just need to
> >> jump to err_mmap_read_lock_failed, like we currently do if
> >> mmap_read_trylock() fails.
> > I don't think that will be enough as well, as the current code AFAICS d=
oes
> > something meaninfgul when mmap_read_trylock() suceeds but vma_lookup re=
turns
> > NULL because there's no vma at that address. Now we would just assume t=
he
> > trylock failed even if the reason was that vma lookup found nothing for=
 the
> > address. The problem is that lock_vma_under_rcu() can't distinguish tho=
se
> > two outcomes, so we would need something that does?
>
> I spent way too much time staring at this yesterday.
>
> I think the key to distinguishing between:
>
>         vma=3D=3DNULL because there's no VMA
> and
>         vma=3D=3DNULL because of a trylock failure
>
> is binder_alloc_is_mapped(). It won't return false until vm_ops->close()
> finishes. vm_ops->close() shouldn't be able to happen while
> lock_vma_under_rcu() is held. So if you've got a non-NULL VMA, you've
> also got a stable is binder_alloc_is_mapped().

By "stable binder_alloc_is_mapped()" do you mean it would always be
true? Asking because in your patch you removed this condition:

-         if (vma && !binder_alloc_is_mapped(alloc))
-                  goto err_invalid_vma;

So, previously if we found the VMA but binder_alloc_is_mapped()=3D=3Dfalse
we would bail out and now we don't. Are you reasoning that this
combination is impossible?

>
> So, if you've got a vma!=3DNULL *and* binder_alloc_is_mapped()=3D=3Dtrue,=
 I
> think you can be pretty sure you've got the right VMA.
>
> If you have vma=3D=3DNULL and binder_alloc_is_mapped()=3D=3Dtrue, you can=
 be
> pretty sure that you hit some kind of transient lock_vma_under_rcu()
> failure.
>
> I came up with the attached patch. More eyeballs would be welcome.
> There's a _lot_ going on here.

