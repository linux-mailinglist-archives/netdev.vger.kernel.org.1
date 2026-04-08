Return-Path: <netdev+bounces-276220-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNlMA5yl1WnE8QcAu9opvQ
	(envelope-from <netdev+bounces-276220-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 02:47:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5092D3B5C08
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 02:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0F5743029A62
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 00:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7AB62E8B64;
	Wed,  8 Apr 2026 00:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MHWFugAH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E8D2A1BF
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 00:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775609238; cv=pass; b=RSVJ1Z33DK5BOxwj0F5ca5BJc4lrXicov5OvguljZUZYtjND8aquUXRa8TW9KBnzZYwU88r9Qp1MihyHjVVvVhhcO67wBpbGBrNWcJ+Q7VMY63Z2Mah6ALWl37n/lsZgPZv6qe0zENR5mDDnZvSpr8qSrTvLoDEjIWzq8otW55g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775609238; c=relaxed/simple;
	bh=DEsI0BgmtgLBAsle4MGY7bLXYBY4CxWUL4evHL89W7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TMjsrrRhLJny+RFoknlN7RrzMMwzCpPqOO2YlWr6pYaiSdZL9nwUPoUtZPrg62Sqj/tfKI5ZZwdwGqu6Z3cgYBszs3zcbVg4PHjGiOqwtbCgfxczahNv/MyjKeky7zPca68braAKHL1VMjLnwUG6PZ6gYaJiWuzIf6t9nbziKB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MHWFugAH; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-66b0dc690bcso3001a12.1
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 17:47:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775609236; cv=none;
        d=google.com; s=arc-20240605;
        b=Vkvqam08rN0ixKkWtmFqnFxDxjOtkf72+V5XGtaYjdPMSyNe4BteYDsLIU3/3JdZ75
         rav2Ma2ThsRSpfuT5mLBpinMFhrTqWMi0nNmXR1IpcpEshj9vYOqg0AAFBOP2+oqVgjU
         yAG0ewKq1UJskqJOYZOgM/4SJH6QUCcysa3FYo9PA8NMK5UKlACcTXylTf/eDhE6eXCC
         OcjH6ruCquQRd1Zl42gt3gNRnyFhUUJMkeQ2Ueh7dA/XVNum8CTfLutSxFe3DgZI1Gmu
         b2tUaF3l0Ohich55B+cp1Mq7GRGnhel+dIlouBibj9VLqxZBO+ti357F+LoDTcReJoOU
         f5DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VhUSt7ISpVg4Y3MHFKzYjd0CV4ZCvpoOMj+LKGHtSi4=;
        fh=DYmfh0ZKfvpCwBz0TZR6tYCuKSHsNUz0FecA+MTr/pM=;
        b=j/iX1b6f961YJtG0rsl/3ba5qsiqK3wIiAyqQV7KryzENT6e4bu/IHP1+yH3CR2Lih
         MBn6SCvWBJN4+HHd3ClUCaFxnw44axbR0fKUJV7sXGmu2HqrW73v4AcKwgXoDMa9F6Hj
         hG9eLmbh/L1iSgt+noHOGi6bCsI/kPoBHmIZLFFwdxLfJSJ10er9MAcWLSjGYj0lOR6S
         MgvXpfNdxDbdAUPhS3g14S4bUrS6ri4TDLCSo+XViROPd7gGscLK05FLrUfQvDOoyWVK
         LgHqt9OmPRtyIQ6QITIECzj59Ifhu06MvD3mX/Ppg64CTuHTMJ5plZLmXlVDAMpvnxfc
         e0cA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775609236; x=1776214036; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VhUSt7ISpVg4Y3MHFKzYjd0CV4ZCvpoOMj+LKGHtSi4=;
        b=MHWFugAHP62a2G5dU/rhtZkCvpGvhteOzbQjCY/KIvcU3X6mnn0Huvsjuc1AL15H3c
         xNJtygcKQq8Uw8vOCrDN4Ca+34/YMGepbiMZi7BLlwkX8Rt7H47xYFo8qh+pDg7Fbyvt
         y0tQY0sOG7KXgFx2IQUzSiUe3ESIftbr7dGI1Y5inSG9BKnwowryFpMdfAweCzGs6Thh
         IftCkwowYp32wuxZKW7/PVLwOSGMsLStqLu7br7Plw6vWppxduVwvbEJVEn+HbSBkdzC
         yEHhiNTu/SclAKs03EY2TwE5SCr9KS3/0h+vqK+/rXZowTak59BUFnDfKGWt3bOwb/BS
         zY7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775609236; x=1776214036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VhUSt7ISpVg4Y3MHFKzYjd0CV4ZCvpoOMj+LKGHtSi4=;
        b=Eo6qheWqrTElS0oY9Y5nHae94YA5SxvCluhWU3wMIE9SI6FAN/W75Y0XSHoqKpHHMI
         NK8z3lsMPcuvF3LtLSTrFeyJDY8pxmipM1H/JbsJnSyUHFuqD0Wnyw2OvGDGcwmMBqrk
         b66yVtIuKgRAA+oOQbqhbh9qQojS9XoNroD6PlIcnkgPsD8VG95xE0sgnZvq5H+ImAXI
         Qk4pRv6oz8DDynfZ9KhIG/ghVJPslpXmn2tZkMARGql9blZTKcESZHn5uYvilxPxID1k
         a3PHmFP4AEGTtib/SyIGTYAfHJijgOxgjYy4X7NYdhmbpIc4TcJhIYueylJuzmyddLAf
         i3cg==
X-Forwarded-Encrypted: i=1; AJvYcCWjZt4xbERV41phtHNr9MnYNkiK2PXtFI+RBakZMCFcnnZhpdkHdZITplctU5Cq/AyPJY3Khlg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkF0pKAQpb2dRcBv2Y37GrnHD478ZSfPyugzZQ/5WUHw3DH8El
	DUTEdMwYunX1codxstm3q9MhCpOvxj5NlSgQ2MpKJIBBGbHiC1WeEZCuZXp28UjJ2fbuf5Ey3Sx
	K3/dkrpWMvNhEnjp+7uZdzUIRpKhOFoN6cJXZsXzK
X-Gm-Gg: AeBDievGzNgYA+mCVbjhbg6BN8I1oq7D0F1snUc40qBWxOt3oaMZyzlWKz+j+evnpt5
	7hRorBmF6gUIbMlfca2wgyDtdz9GOfFB0NayIpTRVbWnl1WBEt7MR8uS8/5HGcAJJj0q8byqzvg
	IgocCVdEZBDrrhg1cGMoK0DbwnphX3pHtLpuphh4ZMWLHg+cubk324Qr7yYoiJf4nMcGg1cc6Hj
	+7X2WfNp+urYWw8yPE6Ef4IiV5hOoH6d7jejFjLN1561GAqK8Mtw3qF2mOHP32vY8YUuPfoY3EU
	AJOaoFc=
X-Received: by 2002:a05:6402:400e:b0:66e:e3f9:ebb6 with SMTP id
 4fb4d7f45d1cf-66f9eb0e641mr16529a12.4.1775609235225; Tue, 07 Apr 2026
 17:47:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260404002149.wtayv6a64vzuppgp@desk> <CALMp9eSqgL5q-MY1xpjqR5oRn5_cb=mfEhNFWusNneS=Mx8UMg@mail.gmail.com>
 <20260404034954.t7iapenzvhdpagxp@desk> <CALMp9eR70eE2U63gzNzTiic0PqJVGv3CBBuVUOVbi3nqbWKZkQ@mail.gmail.com>
 <20260407163943.y6tkh26z2rfktn3y@desk> <CALMp9eTA3cXxuOT4dq=6y1hx52gPH1ywwTEmPQ5-fA-vz6r3VQ@mail.gmail.com>
 <20260407171151.2gf2idjbmph35ypb@desk> <CALMp9eRNVGFpzk_-ajQTuXadMtoY9H-ndUaz78wTT1zDYbTrPQ@mail.gmail.com>
 <20260407191128.b2hr2ttkdpyunhrr@desk> <CALMp9eTK0o7Z7-oTB8ohvmoh-vy-Y2qjdUvbqD6HaEhOEPZmhw@mail.gmail.com>
 <20260407222738.lrartp6evfp7yhti@desk> <CALMp9eQjSqwnvJz4JVzYpMkkTiucSJtW48zC4Hj9GBiUhOH-Eg@mail.gmail.com>
 <a605fb45-f8e3-45ad-8924-1da43b9a9e05@intel.com>
In-Reply-To: <a605fb45-f8e3-45ad-8924-1da43b9a9e05@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 7 Apr 2026 17:47:03 -0700
X-Gm-Features: AQROBzDwO89X4_V9WtLHsu6z2_UbVoDRV4IxmA1X-n2IZi_rt3P0Mq9B7UxbbGE
Message-ID: <CALMp9eRfNsghM_RnDXOs=SJYObfPa5A1aOVDZno_zJ=XotfmRw@mail.gmail.com>
Subject: Re: [PATCH v9 02/10] x86/bhi: Make clear_bhb_loop() effective on
 newer CPUs
To: Dave Hansen <dave.hansen@intel.com>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, x86@kernel.org, 
	Jon Kohler <jon@nutanix.com>, Nikolay Borisov <nik.borisov@suse.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, David Kaplan <david.kaplan@amd.com>, 
	Sean Christopherson <seanjc@google.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, David Laight <david.laight.linux@gmail.com>, 
	Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Asit Mallick <asit.k.mallick@intel.com>, Tao Zhang <tao1.zhang@intel.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, linux-doc@vger.kernel.org, chao.gao@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276220-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[40];
	FREEMAIL_CC(0.00)[linux.intel.com,kernel.org,nutanix.com,suse.com,zytor.com,amd.com,google.com,alien8.de,infradead.org,iogearbox.net,davemloft.net,gmail.com,redhat.com,linux.dev,fomichev.me,lwn.net,vger.kernel.org,intel.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jmattson@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,intel.com:email]
X-Rspamd-Queue-Id: 5092D3B5C08
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 7, 2026 at 4:41=E2=80=AFPM Dave Hansen <dave.hansen@intel.com> =
wrote:
>
> On 4/7/26 16:27, Jim Mattson wrote:
> > What is your proposed BHI_DIS_S override mechanism, then?
>
> Let me make sure I get this right. The desire is to:
>
> 1. Have hypervisors lie to guests about the CPU they are running on (for
>    the benefit of large/diverse migration pools)
> 2. Have guests be allowed to boot with BHI_DIS_S for performance
> 3. Have apps in those guests that care about security to opt back in to
>    BHI_DIS_S for themselves?

I just want guests on heterogeneous migration pools to properly
protect themselves from native BHI when running on host kernels at
least as far back as Linux v6.6.

To that end, I would be satisfied with using the longer BHB clearing
sequence when HYPERVISOR is true and BHI_CTRL is false.

