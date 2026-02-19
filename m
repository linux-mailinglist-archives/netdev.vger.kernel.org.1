Return-Path: <netdev+bounces-259475-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDRzKWQbl2ktuwIAu9opvQ
	(envelope-from <netdev+bounces-259475-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 15:17:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB6C15F61A
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 15:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0287C3001A70
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 14:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382B433A9D2;
	Thu, 19 Feb 2026 14:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="qxhTeYjA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5A3337BAD
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 14:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771510623; cv=pass; b=M7jViRs7ZnCZvX2VTGE9Pr+din06ZutRuDPO6VuGxoO3yw0wbXITf5FN7AJu7Wgi51+xwfgK9BJmn29Sk+xKRw6JC3RmSTod8+46t0AShS1Tnbz5dDzpc87dE38nyjfyFKP9xJY+cJrG4GPuDWRqhj11cxuQmnuYQpU9XG/dbb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771510623; c=relaxed/simple;
	bh=JlBY8XFRp4MnE6DziDAwk80fWRt1DvQwRlFLmOYH2Uc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LMeuzpWuOEtWy58btu0gi3NpCniTw9Nvu6kOiWSZi6mE/UHpq6na8pZBr+Qrq77TikHV2sThd1GrjMn4DA+fYLe2dleN2zpmW8a3zpAPkgXvcpRgMBeTqXCcAv1jhl56q+f/fUkKD+tNQgvkmkDF/5pyE8JxXMB3pSJkJodgaT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=qxhTeYjA; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2aaecf9c325so6484195ad.1
        for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 06:17:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771510620; cv=none;
        d=google.com; s=arc-20240605;
        b=TGBfuTof3btGrqwzOHLwE0vXNG1dKnYyOUecaemKLixzdCNrMXMT76pIGKoUrlTk8a
         1LwaH4WM5iznk5zXmQSWL+IBhNY37/reKLlQOXJt+7oaFalLsBblFObM2/M+/kZ3qL7W
         JtkRpwdG7+btH02QRrv2SDS85o5nXoK88h3XipdcPbVWTRxfZJhOfx1LpJPAhxi9I4xZ
         LkCdsDxOlgs1LvPeFNmHkkN+qc2OZzN0G5y+q4l80EkcH5IHRiwwkF01kKR8W+rLfP6Z
         smKVL9kLS4ZI7ZVJCQ+98emxjxpmp/Rl3B9koSoTxu+KWj1dwFYZhrzDDFHl8/Eyqc5e
         mSuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k4Nze/gr7g20P54cJ0s7Gt3mHwXxTaUQJrEH32PNozc=;
        fh=rsKWzCmZEo1p2Hst8gdy2dmYtRF6aD8KlZw9/15+6dY=;
        b=ja/6K+W78iX2XrUVEauNfA8zq1MHJohWohgtUaMb3LvJkq4I+lyUfwndl3v3TGEw8p
         runMrbySJZf40KygDbwewdqI/FeZvTBSBsXt6ZFNZfOIFysPdSfERTntf+Sm2u9JTsgl
         1XWPgzpBGitzkVDZLooBxWbNz3SZAQOeKU84VgFAPCwrLVQfNrS+Oqe+KeUMgBhieraz
         SBhRWsrtvzeyF8rSMAadaECZo671953jMCtJy/AJYv7wAty12FatJPCxFv0uBDte3G3E
         DmElVZS0+sXD4mgMM+KbKsnVIbGcddnhb14GV0EAqNlJ1WRiqyzkDmUvEB4yuo3H4UAZ
         pn9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1771510620; x=1772115420; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k4Nze/gr7g20P54cJ0s7Gt3mHwXxTaUQJrEH32PNozc=;
        b=qxhTeYjAOzzzI7vnOnB3rUoaAU+a0ygLKBptI7NLD2QQfsJ5hMWy+CYzNrTS4YmBsv
         NGLboIbhfGi0FZysNXR49BmWIeUjGpWdipPv0Dbko/VtOtJwBf2qtTPoHVkGk0nis1Uu
         x7/BK7jDXAC5ELC4ZCRlVQHNuAtTpZymlccT9gdeFKZCJRz3cTgpMV+vxKg5ylqZ9qYT
         cEIup8fHqFCGgWPEanOsbuTfkpAjKsbX1aRm47c4NXMRjfSgHoFvaj9qyOmaIwUZEulG
         tSc+6Wv+HSIp+sPOmvCDGQb4TmbmgksenryYYlsoCXyZjQO+eRP5hrWcmfzGv8SsLGqv
         tTNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771510620; x=1772115420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k4Nze/gr7g20P54cJ0s7Gt3mHwXxTaUQJrEH32PNozc=;
        b=Ih89sUkGXzd+ebFdT7MFSyF/tsxwSpLKSidtTt5tXYLkx3gIGzcFtySgdioRqFhF2D
         JEAHrspmtCaQcMytjJgmfODYhFvbOU4ZTrjdPNF/faJvrcSvON9/C5UQvN/KdT2lQcvg
         nGjOF88VnWOugCIksvWgrK/3/EuAMrEyWrVkirs5Gj3rVqrn3dDPVOl3Y006/gpwRjxa
         qRHCfwUBWiKHwkQB7YnXquBas2IO9E79SP5OAzZQ59r1aJijiH3DB229QPSLj1QvshwJ
         OqCXqruMsoY1K1C4LTXXaohilvC77VpFxu3jq+54UI3tW8hSYsGiwi6E+eTYOgxrU6Ew
         uV1A==
X-Forwarded-Encrypted: i=1; AJvYcCUMFkhkiivZ/FA7c5k+2UwHupOaEjnrES8lr9BRVhWsORvjqRk3rnpl8OTHdvnNzG5j9fyg+lo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFy79M6eLWlyxpGRHeU9Auop5ThPey9nfTWpDIUwkfGPlQ9ISY
	Q4c8NwFd9huVpyb004of3c+2P+0tNCJkBGqxUF0gkumHC+sXdWRYKMIJXXnyVc4xwQxZEQ4APHd
	tJjN4rM3SATHacj79F8HCSyAFICkdj+KYVDlCPsGH
X-Gm-Gg: AZuq6aIa9kncDVpPi2s8UfotAy1D3UTM9uUQjJkcx+qBDSPGT0a4AWpAFdG0EDOiy+j
	dUzeEJGyJoLV/ECU2HliaflIOSnuYLqdM/p1QDAzrN+Vu+CJTCEnOHNlAKZjF/GjlzfptzzwPf2
	jc8yZC+v7exDuTB/2lerLCbLXr0t23UQeh3DIIB3qQgfSXOQJkpMG3lkWB9Glk42YuBL2NYg8lL
	lHJXQqhDhUz6MVhWPhX4C7JJQ0levFvq39DJTo9PqDzVwFIy0nSxQJI2BAkwRQL3+6pLunCoc+H
	eASU3UKmnA0bPEA=
X-Received: by 2002:a17:903:4b4e:b0:2aa:e47d:e3b with SMTP id
 d9443c01a7336-2ad5f531d2emr21934295ad.0.1771510620191; Thu, 19 Feb 2026
 06:17:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <674b8cbfc385c6f37fb29a1de08d8fe5c2b0fbee.1771321118.git.pabeni@redhat.com>
 <cc6bfb4a-4a2b-42d8-b9ce-7ef6644fb22b@ovn.org> <ecfc49ae-99c9-414e-8b8d-211112fc5873@redhat.com>
 <b6b67235-bd7b-45d3-81e1-49a2a1f6b241@ovn.org> <CAM0EoM=g3ahJ704qDQmr4s-4sDJqbyRvWNDchb3YaRbD0zdyKA@mail.gmail.com>
 <90b25744-76e5-4d9a-865f-72832bbedfe5@ovn.org> <CAM0EoMmgigcc9aYmoj_vEM4TpopHDFjyjbdFeVyEN8QzVLb4vw@mail.gmail.com>
 <CAM0EoMm3zkJpkHkwHX0YQDSJD_gEMphihZ3CC+b1dMx49bdjWg@mail.gmail.com> <d07fdeb8-2b26-43f0-8fab-28907e88bd06@redhat.com>
In-Reply-To: <d07fdeb8-2b26-43f0-8fab-28907e88bd06@redhat.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 19 Feb 2026 09:16:48 -0500
X-Gm-Features: AaiRm52OwvOmOEfCtlF8bDf3egxqQPXE64VEBrEXvLtKnjES_uhnhhriUOuc2rg
Message-ID: <CAM0EoMmq-aN98=TTh7YkODFr2DmZjD=Lzp6roGiCBog1tT9Lyw@mail.gmail.com>
Subject: Re: [PATCH net] net_sched: act_ct: drop all packets when not attached
 to ingress
To: Paolo Abeni <pabeni@redhat.com>
Cc: Ilya Maximets <i.maximets@ovn.org>, netdev@vger.kernel.org, 
	Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Henrik Steen <henrist@henrist.net>, Olivier Tilmans <olivier.tilmans@nokia.com>, 
	Bob Briscoe <research@bobbriscoe.net>, Olga Albisser <olga@albisser.org>, 
	GangMin Kim <km.kim1503@gmail.com>, Eelco Chaudron <echaudro@redhat.com>, 
	Aaron Conole <aconole@redhat.com>, Florian Westphal <fw@strlen.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259475-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[ovn.org,vger.kernel.org,resnulli.us,davemloft.net,google.com,kernel.org,henrist.net,nokia.com,bobbriscoe.net,albisser.org,gmail.com,redhat.com,strlen.de];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,mojatatu.com:email,ovn.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mojatatu-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: BCB6C15F61A
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 3:43=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 2/18/26 7:44 PM, Jamal Hadi Salim wrote:
> > On Wed, Feb 18, 2026 at 1:31=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.=
com> wrote:
> >> On Wed, Feb 18, 2026 at 11:15=E2=80=AFAM Ilya Maximets <i.maximets@ovn=
.org> wrote:
> >>> From a user's perspective I'd prefer if RTM_NEWTFILTER just fails whe=
n
> >>> it contains TCA_ACT_KIND "ct" with TC_H_MIN_EGRESS.  This is clear
> >>> for the application that makes a request and for the user if they mak=
e
> >>> the request manually with 'tc filter ...'.
> >
> >> The challenge is actions could be created as a standalone i.e "tc
> >> actions add action ct..." then later bound via tc filter. Don't forget
> >> actions can also be shared by multiple filters (which could be a mix
> >> of egress/ingress)...
> >
> > Actually, looking closely at the code - this is doable. Let's see if a
> > patch can be cooked.
>
> I discussed a bit the topic with Davide, it looks like the thing you
> mentioned above could be handled. The problematic part is AFAICS the
> additional indirection level added by (possibly shared) blocks. AFAICS
> whatever check we do at ct_init() time, shared block could later
> circumvent it - unless act_ct is always forbidden for shared blocks.
>
> TL;DR: I think admission check at init time can be implemented only in a
> quite (too much?) restrictive way.
>

True - the blocks will require more surgery but seems doable. We may
end up again in ->quirks() land here. I.e when an action is bound to a
filter (not necessarily when created) it should check its fit in the
graph and see if it is legit. But since this is only the second quirk
we know of, we can simplify. Note: We already have one such check,
albeit ugly-looking, with skbedit (see flag TCA_ACT_FLAGS_AT_INGRESS).
I will talk to Victor and see if he can cook at minimal a preliminary
patch without considering blocks, and at best one that does consider
blocks.

cheers,
jamal
> /P
>

