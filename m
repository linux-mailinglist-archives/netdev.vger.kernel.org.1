Return-Path: <netdev+bounces-277050-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMGkB9zI12k/TAgAu9opvQ
	(envelope-from <netdev+bounces-277050-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 17:42:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A783CCE6E
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 17:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 656CA30A7190
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 15:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A953DEFFF;
	Thu,  9 Apr 2026 15:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ILPY4gfn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0288D3DF01F
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 15:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775748583; cv=pass; b=RH+AHvlz2eL6c8uHVfKSIzwPnUX7IHSXohbsifvgz/1T6rUoMjH4z7Ysgh2aIj/RRqFfELSICkBNvUO7Ld83DWxAGe6VX2WgbSqEe+ZxqsMDmOSSnBAOy11qAwgsQXmFRWcn+KAdg2bzkmYFgpEy4pE3Q9opVU4hP9kzxuXuN58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775748583; c=relaxed/simple;
	bh=x9GSh3Zm4OXtSq0jQU3rRGCdIRW1ZWbDoaw15nWkSWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FoIw+K5CGDA+dNCBwmNcM0OBm/FPY2GJV8HJQNv7MIWC9aLsoqdQLzu57fAX92bzUgwTMdpq7H3r3QvUmUde8rbv5M5Nlw+ytXbGGUqCwPB01BbwKO9OhAPQ4WNMBC/nXZ0OKsu7PFjos4yiMX4FmtHE5FkPWQCX+rDTHGJPGeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ILPY4gfn; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-79db5e18ac6so10640057b3.1
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 08:29:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775748581; cv=none;
        d=google.com; s=arc-20240605;
        b=NjffkqiCKPdpX7V6ULZGckgMH+lqE1SDB7OfTwDR5JUQU+Mbd3mQ2mXBRrBON6cmBU
         XcWQN8R55XBnGpgR+WDOlscjY6gACrCY0TdoTevHNRDG6RukNb7Hij9rZMuZPMpisQ0d
         8jUdFnPcLK2yV8zkEZQyaSqKkegkBRgABnZ5vESa4wiB3TAqyBrtQECz946AV4h2PJlc
         R7lOpUL3pwXgIAD2YvFNhbAIM6sbPG4MbInBKPOGrLVhaGpL3T3TqkylxLPZAXtQsd0u
         VyTZ8DPN2FvhSoZiX/ZEDMIjNorYxU0lcAX9AYdlaD8CHyPBcyNcrg6Gg0UL1S6tjohP
         kgKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=x9GSh3Zm4OXtSq0jQU3rRGCdIRW1ZWbDoaw15nWkSWM=;
        fh=RiyrFOGqRSbGf5FxcD64CKq9STLxTvT8waRJmqs3vT0=;
        b=Hw1St8rnqyr+QC19FNTpOWXYFRFo/5j69WL98ZREBYHAwrnd+YF7V7ysU1ZmZSEgeg
         t34AhSRzQzg82VZrUkeG/pgnSL3OC2zvknkLdurRQQK2pKqkaNW/1sEwPQP9QoRqSMnF
         Og/hEUACYFR6QpdlWb7TwJEhA1usfDeTNgIExmBrpAw/NmW87cxdOd2Tsm5nv3jE8iND
         QBSBMBMsENM/1gosidGPhs1k68OV7ur6HiYRV3ddY5iTE81Cy2NAcPcsMEVpvWlsFaAW
         aenpuR6xn7xyCA2VgmlTr3TmhABT0B6muegY/xwReeqEwB3/Jukz8kUpfdmdAv//LKLm
         wJ8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775748581; x=1776353381; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x9GSh3Zm4OXtSq0jQU3rRGCdIRW1ZWbDoaw15nWkSWM=;
        b=ILPY4gfnkD1neKTACXCPfDBy3nb003/b0VboMViRmHDVMI7BDA4VAbXfUZ6k32AzvQ
         60asBlPnjaoP73hbMJgr8eO4bI7VcICPSDDKr2ctqm0T8n7Tz6UtTA4GakAL71jtl1S9
         0sPAzgDFtom2PqZ5o6swsHALxnMOjMC5an1AoGxPKrwNTialFqIRU+LkeMigVbUBrric
         v7GjlhDZIfrUncmk+E71ULb8SHaXKoMKPngvh1j6DWJZrnNc7pG517piXtk79ma23Bvu
         dlz/fv+OeHpVgPdmpQ0N1ysvJcCYL2dBDcTmL0RFIMkDNpL7A5vwtZ0xtX1dac6GDS5c
         T23w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775748581; x=1776353381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x9GSh3Zm4OXtSq0jQU3rRGCdIRW1ZWbDoaw15nWkSWM=;
        b=AL98Oc+VOraiyV81mKmUjkPChkUa3LmpFsfBmB1CeuooME6JnHyX4hJLNI0OJ8c1ll
         MPdfNtLfhyI19wQtCXUwzRIZ1VlHUKkSSmmMD+SX/+an8fhvTXp/Cdla53dOQTJdP9GS
         ovgvBHKNv5bxuKqRTFRJXcwiPMkCgUx5nzKp5TWghsIAEhMhCsj9Uf+xxKLDOwBNqQKJ
         5Lh43fwX5lpKojGConkpCciS66bopEZKpj6/XnXq5aha1qAs0f0/doRuNOzJtCcwuVXb
         IpxPYFZvnZ0mBSAyatW6lWXUzPDQZTaM+IbgvqAshFGFpUs6vVVhkQYZScWHnoKLd1tI
         N10g==
X-Gm-Message-State: AOJu0YzNl8c/XFpa1+CQcn0yucafjnwNrN4t6cCRVzSCCxHNUpUP3AhC
	HKvkJE+hXRMP6JAXCmFTjDmpz14tSVCUjr9AXzJTpZ0Pv0YNg4+7b+cn71OHCkHsIPxRgAc4aHB
	IzdMsC0vHAG6R9ANDIcIlNzc076Uf1VfV+Rh1Blfl
X-Gm-Gg: AeBDies5bR49Y/UE/BPnoFwATwnGvkmDb3GxkSwZmXz/5ej7g/edDkOb5iJywguxbku
	TL8xbV9WeyokBVOKRR6r1UfKpYTMGJ8f2ozlGsY3gtHtdA0AnP5e11yJCFyj7sd+mM5xttvvomZ
	GbeIORGZ7doPvCrU+6WVy/u58jAuKT+b3r0YQ5HvHCNv5QvK1RQVK61i2W7bA9iAviJC7IfE00i
	doSslgI1MMF3GQwPsBQD2lRU5QddofPUsiKZkdXpCGhMTtqQV5uiQh3eyxvQrBiBqpMBrSXzulG
	5CfxTamaJT/4DljW5Q==
X-Received: by 2002:a05:690c:f16:b0:79a:c9c1:eb29 with SMTP id
 00721157ae682-7adeda869cemr37882417b3.19.1775748580519; Thu, 09 Apr 2026
 08:29:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANn89iK7bzV0VpPsP5nu0mV3GCsN5MOZJgc_s8a3B2X6Ui6mxg@mail.gmail.com>
 <20260409152400.2219716-1-ashutoshdesai993@gmail.com>
In-Reply-To: <20260409152400.2219716-1-ashutoshdesai993@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 9 Apr 2026 08:29:29 -0700
X-Gm-Features: AQROBzCXDPlzFz1E_DesM4BAdot9Qun_7KfOdrYkd5ipizEicj7MBWk01jC-U3U
Message-ID: <CANn89iJL9VNa=Rj579LZgD_TVuqR-hq77RS5hf0yaDzwgnUR0g@mail.gmail.com>
Subject: Re: [PATCH v2] ax25: fix OOB read after address header strip in ax25_rcv().
To: Ashutosh Desai <ashutoshdesai993@gmail.com>
Cc: netdev@vger.kernel.org, linux-hams@vger.kernel.org, jreuter@yaina.de, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277050-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 50A783CCE6E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 9, 2026 at 8:24=E2=80=AFAM Ashutosh Desai
<ashutoshdesai993@gmail.com> wrote:
>
> ax25_rcv() calls skb_pull(skb, ax25_addr_size(&dp)) to strip the
> address header, then reads skb->data[0] (control byte) and skb->data[1]
> (PID byte) without verifying those bytes are in the linear sk_buff area.
>
> The original fix checked skb->len < 2, but as Eric Dumazet pointed out,
> skb->len counts bytes across the linear head and any non-linear
> fragments. If the two bytes needed sit in a fragment, the check passes
> but the direct skb->data access is still out of bounds.
>
> Use pskb_may_pull(skb, 2) instead, which ensures both bytes are present
> and pulls them into the linear area if needed before we read them.
>
> Suggested-by: Eric Dumazet <edumazet@google.com>

I have not suggested to fix a bug in ax25.
I added a comment on your initial version.
A "Suggested-by" would imply I made the initial discovery.

Please carefully read Documentation/process/maintainer-netdev.rst

We require a 24-hour delay between each version.

