Return-Path: <netdev+bounces-296357-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2ppeEyE1JmrRTQIAu9opvQ
	(envelope-from <netdev+bounces-296357-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 05:21:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BF06526AB
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 05:21:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b="bANG8O/5";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296357-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296357-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 002D33019BA5
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 03:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C33348465;
	Mon,  8 Jun 2026 03:20:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1F3348C52
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 03:20:47 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780888848; cv=pass; b=hXHXt88ou7r85sZuBbxaURc7qpxUbm3YOHY6wzmJe2Warq7x6CWrLd9xo5iJF4D90vlBMWyewj7+3JVaOfuOgKS0JNsCuiBBIukKzRFaDIAJIile0qOjPhT1afnWRVTpiOpZzuQ4CXh90nQBTVGAtCjQmlJvINMOmXujMIBTbZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780888848; c=relaxed/simple;
	bh=n5dmSXcfz3rDEurx9aDAnkub1EWJT+Vqpxo1CbpJgXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T1PpxT4O/OYB264B87CwkJq3BDFyT29lNA2mdtIcbZh3DHW5mDlFWGT+G+8npdfkWSdMmvs0h0VmGOgpK9KdrWnRyhilAPy51UJZnd5YCFVlYJAp/SlmtpVsBOUuszf/Z/YslAEnxiIPgI/ZMi5BRf9NJ54g+pfDdSWwdy+HWaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bANG8O/5; arc=pass smtp.client-ip=74.125.82.50
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1382533d428so1329897c88.1
        for <netdev@vger.kernel.org>; Sun, 07 Jun 2026 20:20:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780888846; cv=none;
        d=google.com; s=arc-20240605;
        b=AudXXxM7NEsc/A+wz8lLySgu7bW865o1RX8slddD/hbpgNx8vhIlhplmVA6ATX2056
         cH6KutufwLdWIERPD1BTM016RUHMwCJAI9goXIDO2zzD96n/RGT7xXqStgM3BwXgstmg
         Dezic22FZuxvPrt8B8H3BFYww3HvvA6TKvxtdZQLptn7ftTPgjeF7CK24TpkA7YtAJX/
         o7woFBaPB5yIZYs3cuX/cxZiBJh1zjOK9lO65SwiBUUZD7lbpMsrVvxwhQsIF6IUU938
         uXO5jsFF4wg2LvJjYzk5QgYoNdMR6cF9jC4QsGvNY5PhCOYBnfTWbbOneTRLufJZv5iA
         gdqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n5dmSXcfz3rDEurx9aDAnkub1EWJT+Vqpxo1CbpJgXA=;
        fh=6DQGJoXeB9+KIj+iUfv+Ie0+wNoJyPFvjVIFFJcvOJs=;
        b=DXnmLhCG+qzI8fZ6kZDAMq5pNeauOAWz1YBdfghCWkpGmbNvXrJzbonehCxrgd8vjc
         h0gml6VO/hbaOS5GOoCX3ipvnJdwRoPqnAuus3A5643dLZaP1QeetwpzUjS565VGFd+b
         ImjC+stXiex4PsSORflJRX9kRjhd9py5lmb1WCc+7sOZ7XpaqyupW/1VWz5ZwxfSBBYa
         HLUZ2LZFdq2NgvTqL1PHmGgKk6Z29W8sYSYqXErOFTM1fOZIyJmDtOvbWUBcZyB336Jn
         o8n8iYJCsVgZsGn1eT9oQ7zEI7g5r3yl4fOR/cvKT4awErEzYCxc/QQBVLls/ZwdZciK
         4efA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780888846; x=1781493646; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n5dmSXcfz3rDEurx9aDAnkub1EWJT+Vqpxo1CbpJgXA=;
        b=bANG8O/5q49XoKfgIPfObaEXY41aK6wP2GTRucqtfC9x+OIpgENIDeVyN9jcYxANq1
         3Ma9g7PxhTvpDvlwvhDL0pN3wUhFLBdEcbdzk3Qyxle1Pgb27370H3tn+LzyL669piQk
         hbl0LZ8KrMnY+kvARJMnwDaEXRK3UmTRtl5STab+8fZD0WzRDX/fOjnE9oeqJBkS7oXb
         +Qa5k3HwI/SvrjglZjnL2gB1L3VZw4WFMOStgodoMATGcYxZ/FiVwnsqHRHr4ZCQdFxZ
         ZZmTmg+igxfwiMIQT1+t+jN8GX+mg/A1h3HUPWYU3fKuEuboh62NCmjcW/1gsVKM9QPe
         FHmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780888846; x=1781493646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n5dmSXcfz3rDEurx9aDAnkub1EWJT+Vqpxo1CbpJgXA=;
        b=qRWQ/fxlV9OEf7T5/GcXZhLfygb89sSswuFy1ipHI5w61/Xo7DFwoB71MlvZKi7O/J
         dDH6lWAfwhNkLnDQSVMb5VcZ0vZXVh2IjBZeaMuaLerdbdPLOCYUa5CARekxnMqVO/aK
         impSo/wneENl+jfIRmzZB6OAyZnyCvIaHOCTBntz6SkBn3CivD3ihOqwOI4hpLHYQSTq
         Z3MiZf7l8LF1tapdg4Ajpwo7nC5/4U6Eg4xGhoiqjhE/aw8RTKLYJYrpad9osEOSSvJu
         uK5OO0zHwgDOfUNFKHkolYEZ2I3ZGFc2uaQ4sFyFwuEa4Hzwh8JujhfVUsW+X2nfkt1t
         VcVg==
X-Gm-Message-State: AOJu0YyKMznCM7Y4hW9WxCOLjBiglpZrN+4us2jfBJZa3rAps2/fvu6U
	Esn8lRqEN2sGNzsl3cRAcTkwnqikCRe4QgvUEmOnm0LjZIN8cNpuqm88CgHfbDxg0pvZLRTjjmA
	9YxE7vZduKvhtTa9/1waL1BtDRGsJfooNm0e4lhgu
X-Gm-Gg: Acq92OHWlN7nuTlCHYTElfh9iyLXzfOGS/EdWos+/+4evzZ7REIf+gIJUWaerLj6Kst
	916m/v+Gss9Dt8BUJOLOHvufUNY+U0kAiY7gKR96hmJDIHs51wTVcOWrMilegIbsUfN/LtJRUSJ
	xia5sYn0df2cnsHvvNOly46B76zHkzKw5qtOEuCo/S2aia3xihGwRVbDTRnxwk5H2dQglprFh3U
	Lyd4N+MeeDo4UFRiMYFzET+/jBaZf/bTvgDdbuEOZuFvvKlBoLWGPQ7UMP94DC/qoly3Aatm40U
	jC35qGqVc++h9iSfBB6C6QoPgm0PMBLs37RVeFdllVA42Uz7kSRZoqgpJHiB5SeFEIqJEdAMrYc
	P2YPvzKMwy7ueO74B70M3D2lsjMOJyMg16iOgBcAowHtnTAsowI+Ul8jPvYdkxtxCbXs064eMdA
	==
X-Received: by 2002:a05:7022:204:b0:137:ee9a:2ad1 with SMTP id
 a92af1059eb24-138067331cemr7310199c88.35.1780888845644; Sun, 07 Jun 2026
 20:20:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607021819.49698-1-kylebot@openai.com>
In-Reply-To: <20260607021819.49698-1-kylebot@openai.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sun, 7 Jun 2026 20:20:33 -0700
X-Gm-Features: AVVi8CegaGs5DKKwklNrjaPKS9Iw4Doaml9c_Rs5E5g6WykhuZ4UZi3ZPfPRxHQ
Message-ID: <CAAVpQUB_Bz8zZ3jA8yLr=+Lh+wE7eVS6eccfDTTk8yu7ofkgGg@mail.gmail.com>
Subject: Re: [PATCH net] net: guard timestamp cmsgs to real error queue skbs
To: Kyle Zeng <kylebot@openai.com>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:kylebot@openai.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-296357-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,openai.com:email,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A0BF06526AB

On Sat, Jun 6, 2026 at 7:29=E2=80=AFPM Kyle Zeng <kylebot@openai.com> wrote=
:
>
> skb_is_err_queue() treats PACKET_OUTGOING as the sole marker for an skb
> from sk_error_queue. That assumption is not true for AF_PACKET sockets:
> outgoing packet taps are also delivered to packet sockets with
> skb->pkt_type =3D=3D PACKET_OUTGOING, but their skb->cb is owned by AF_PA=
CKET
> instead of struct sock_exterr_skb.
>
> If such an skb is received with timestamping enabled, the generic
> timestamp cmsg path can read AF_PACKET control-buffer state as
> sock_exterr_skb::opt_stats. With SO_RXQ_OVFL enabled, the packet drop
> counter overlaps opt_stats. An odd drop count makes the path emit
> SCM_TIMESTAMPING_OPT_STATS with skb->len and skb->data. For non-linear
> skbs this copies past the linear head and can trigger hardened usercopy o=
r
> disclose adjacent heap contents.
>
> Keep skb_is_err_queue() local to net/socket.c, but make it verify that
> the PACKET_OUTGOING marker is paired with the sock_rmem_free destructor
> installed by sock_queue_err_skb(). AF_PACKET receive skbs use normal
> receive ownership and no longer pass as error-queue skbs, while legitimat=
e
> sk_error_queue entries keep the PACKET_OUTGOING marker and sock_rmem_free
> ownership.
>
> Fixes: 8605330aac5a ("tcp: fix SCM_TIMESTAMPING_OPT_STATS for normal skbs=
")
> Signed-off-by: Kyle Zeng <kylebot@openai.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

