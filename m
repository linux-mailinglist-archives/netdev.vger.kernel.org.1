Return-Path: <netdev+bounces-292696-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHnyObdHGGr2iQgAu9opvQ
	(envelope-from <netdev+bounces-292696-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 15:48:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FF65F2FAA
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 15:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C6C531806E7
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 13:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E163EFFBE;
	Thu, 28 May 2026 13:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o2M6/K0w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541B13CE0B8
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 13:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779975725; cv=pass; b=TLeZQbHyt2d7OP0CxhvZbO5yzoCZB8P77YCld5S6QDI+IgIxUcvc17S8xpedsBv801JOdxhfPmftx+GeefAPtX+QAVs3ofFDPLBZXnY2rsAiC3j0g0wSdYW4gFG/9KkF+Qu7ySduAWYlGiHE5nxOtnrJIn0Uwaqv2KuhyPV/nZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779975725; c=relaxed/simple;
	bh=ech48L+YtHB5+v14LJc84EaiJ02dhLWh5PJBNI19S2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mET7Eue6yxN9p8oT5Lo6Jp3Y2CZX0HQnMm/vH7ErrVXB+1YUTGa0z2DkWilAtoeQOMZnqe0Kpzo+IXGEKGGF2jsfsmwfqtLvdE7ToPOEyMRp4PKQ9Es8AeDCtWO27UrZsAq9EZODAV+zsikrrCHzmi4GGW/XjcudliXo/N82iKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o2M6/K0w; arc=pass smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c80227b1f6cso4782279a12.1
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 06:42:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779975724; cv=none;
        d=google.com; s=arc-20240605;
        b=UTjs/4gSP+TlnVqO1qKeQ9Tqo6MNgk+1rGsUi6try/Pa/9FD/duOkk/JFNluRHonaN
         arPo2hyUYFlRa90xP/BuWBwROf+uq1kphQK9jRxOckvlyP5sju5IQ48jbybZm2Gucd7U
         NlHObVrTwgqt5AlT2v18vwucnVPRzaFI8C1N0oEIBMoOG1tsywG7IeoYBhil58JP+eNe
         xIMHj5N9tuwf3l//DyHA1MVdSueJSrVnmrHfqOEHZJg0A3VqMyU8p4yFM9IMku1n+IvM
         TqjJM3yJ8HzGOY0yRCPTsnW/b97QR3KSpytQLaoMwpSvU+amRVPJfkblieizvOvfE4zC
         JOlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8R3ZCxKpbNcmdcqfZFVwiYeS0XVSXQ7IH6lz3U+ld0A=;
        fh=YurUI2V4TRAdUulx2jbDUKX7pwD6NDursyxIBynIQ3I=;
        b=LEYlx6T82TcEFixgj+pCtoXviMq1XpiF+0IQfaYUBpRmi1dNbMZkaccOqqZeDMTBIm
         NsNU3Xhm7G+cUVoIobisPlPbvnZjCkO7U0HM29QOpQtych8MZWUrXMh2zuQE/P1fOOmo
         7Rl75n0ELlMAxGaBKNE6HfIfvzFRon7h9iPopebGvN3UDNmzhRX9QbH2AoH3XyEgEB8m
         /8vpZHxm/rjvJ5y7l3b7HDh1uJpuoab6K9xAFCkRZoDTKdrOBYJNVqtUDyhdOxxE0EAR
         KsdnTxuRy123W0hpHKtrMvAfHzJAHbAadPfs3NRnoDLupUEx96NekNV4QJ4Mqvnw9vk7
         0a2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779975724; x=1780580524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8R3ZCxKpbNcmdcqfZFVwiYeS0XVSXQ7IH6lz3U+ld0A=;
        b=o2M6/K0wNGzWFIc8YpZwTVH162ouWX6u/9u3SFTEfwMTa7LbqwLTDLSENYvRMcnZsM
         89zAOzaCOFHsMZzlZRbv6biLCsT6pSrlskrdGaRP7y45eEgRJvjWr5tPFIzuueNsRMMC
         TZiMnXahzyDZ2Pq7yN7YA/d15tpPQVHm2NAboV3RZ9PcbymM6ddmxNIN7+70GxiRDcaT
         y/05QScHrQgyDl5wLq9tyKokexql6zXYD5WtzTZ1C9E1Fk4RX0UDGeFFswQUKV3jyzWV
         jVo3B9YtP6PbDcZepCRCVjKq73LhGNThxe/CDPuG/ZSRtvXGE7IiIW62KM9+biDTxhr5
         380w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779975724; x=1780580524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8R3ZCxKpbNcmdcqfZFVwiYeS0XVSXQ7IH6lz3U+ld0A=;
        b=KW2Bbz3Jrcbb7iqsjdtO0AkStNCIa8mfmvUtgfeupMe5UkoqYCHjDa8JUTW0iaFpKF
         Q9VJIpVvv1VJAx4uBeDROBhWIouKTHekdUPwoNSJ0faMz3PqJODKeioDZ/ALW4/JNtka
         ZVokBeXpwPvEAOg3fiqAaVjwYT6DV/O4PBB0dDOBKGmZAtXngPyzzOzv3dEvLH8roDGx
         EXTqi1eBZxjkjrVoc3qB/BqKpBfO+ZxAP+nfHuySeqdi0HQmBsvLPh8RP+fqQq62pcW/
         o7lrNcyZbgWQ6xwGak8QTcd9P82PWNOeaKprpiG3QI3ccmu9U6pnl5fZ5sh4hERw6kbA
         rfSA==
X-Forwarded-Encrypted: i=1; AFNElJ8LcSNyoJD6/zGL6fF8YKTShF9E1PWWow1E1z9IAiQocjuIpyPk6uuULse7yWH1c2sY7mu8BYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBTplA/CJN8WwSHkhfj9msQKZIeoIoifUCKcdCRO4z8h4Es/Bz
	4+lERy/sOfvz2usOiML/kzR+lvtrzJ2vDImQWwNg70bj7YHJhTh+Jh4z1tv2UlqhXqr2Rcorj32
	fF0dPM7IKztyPY2YufvPvHPpOtWXhnyAl27j8
X-Gm-Gg: Acq92OHm8SMKk6VQAjTY5VIBQPGMzB/hQJ74FWcaYy+2FBZNDzDQXrC+Qg7UXlAIunB
	H/tVYXcvpoTYAbUKQL3w+d6T/BMw+abHu3YTQ0PNjS6z9LQ29OdDodJDb1TZz130xiUba0GIsDA
	07gV5CoR+8XSU59gu2O/RaGSJ8En7il/aGUmRp69aClF/Af7rvYKE73EG/gk7QDZFkIuYLGDdsd
	DLywX/QRbOxh+mU/eqe8Cq5mRUK+wcWLU1I3NLW83jw56jN0RrkQuIDAO/9OGLt4ZODAHJzpdWm
	oGpsi15ekIkQlPsC4uCcZdcHl+x0Zmr1RAblYKNQPZx1glien2oiGL6rXT3pCju8IFTfGYTtj4D
	xI38w2M3kICNzhEN+BorbNYaNFOsTd2wIjSdOplIUoXg2kgjs5xU09BTHW8xhlw==
X-Received: by 2002:a05:6a21:1bc6:b0:398:6ea8:21d2 with SMTP id
 adf61e73a8af0-3b328d4c0bamr28789330637.19.1779975723578; Thu, 28 May 2026
 06:42:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527032411.60959-1-kipreyyy@gmail.com>
In-Reply-To: <20260527032411.60959-1-kipreyyy@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 28 May 2026 09:41:51 -0400
X-Gm-Features: AVHnY4JDED5tqgKLQimcclOHI34tUsvK1WY-SZ9YwxPKLW0EPwRo2z7dpR7qoIk
Message-ID: <CADvbK_fDMF8sAPcskb_WsL3d+4gSunviSZebsFS-XxQG2HUUCA@mail.gmail.com>
Subject: Re: [PATCH net] sctp: fix race between sctp_wait_for_connect and peeloff
To: Zhenghang Xiao <kipreyyy@gmail.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, linux-sctp@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292696-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url]
X-Rspamd-Queue-Id: 57FF65F2FAA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 11:24=E2=80=AFPM Zhenghang Xiao <kipreyyy@gmail.com=
> wrote:
>
> sctp_wait_for_connect() drops and re-acquires the socket lock while
> waiting for the association to reach ESTABLISHED state. During this
> window, another thread can peeloff the association to a new socket via
> getsockopt(SCTP_SOCKOPT_PEELOFF), changing asoc->base.sk. After
> re-acquiring the old socket lock, sctp_wait_for_connect() returns
> success without noticing the migration =E2=80=94 the caller then accesses
> the association under the wrong lock in sctp_datamsg_from_user().
>
> Add the same sk !=3D asoc->base.sk check that sctp_wait_for_sndbuf()
> already has, returning an error if the association was migrated while
> we slept.
>
> Fixes: 668c9beb9020 ("sctp: implement assign_number for sctp_stream_inter=
leave")
> Signed-off-by: Zhenghang Xiao <kipreyyy@gmail.com>
> ---
>  net/sctp/socket.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/sctp/socket.c b/net/sctp/socket.c
> index 1d2568bb6bc2..66e12fb0c646 100644
> --- a/net/sctp/socket.c
> +++ b/net/sctp/socket.c
> @@ -9403,6 +9403,8 @@ static int sctp_wait_for_connect(struct sctp_associ=
ation *asoc, long *timeo_p)
>                 release_sock(sk);
>                 current_timeo =3D schedule_timeout(current_timeo);
>                 lock_sock(sk);
> +               if (sk !=3D asoc->base.sk)
> +                       goto do_error;
>
>                 *timeo_p =3D current_timeo;
>         }
> --
> 2.50.1 (Apple Git-155)
>

Acked-by: Xin Long <lucien.xin@gmail.com>


Note that the pre-existing issue reported in
https://sashiko.dev/#/patchset/20260527032411.60959-1-kipreyyy%40gmail.com

I don't think it exists, as the state of any of ep->asocs should not be in
CLOSED state. sctp_wait_for_connect() can only be triggered by the path
with sctp_sendmsg_new_asoc() called, not the SCTP_SENDALL path.

The reason why it doesn't return the error from 2nd sctp_wait_for_connect()
is: there's already user data enqueued at the time, we should return the
sent length to userspace even if the asoc has been peeled off.

Thanks.

