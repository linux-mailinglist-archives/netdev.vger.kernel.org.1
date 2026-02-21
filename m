Return-Path: <netdev+bounces-259803-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SxFMF3AAmWnGOwMAu9opvQ
	(envelope-from <netdev+bounces-259803-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 01:46:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F6D16B980
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 01:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C2D193003BDE
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 00:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67239476;
	Sat, 21 Feb 2026 00:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBolUUA0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6903FC9
	for <netdev@vger.kernel.org>; Sat, 21 Feb 2026 00:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771634795; cv=pass; b=aABAFxe5CaRKnEXNS873hj5J21KI3Mx+GlDfxgieD0As24YEima0J4lmhNEhu+0Py0KEq4Rf8rnvsSjFZBmfzcgv96STk0GKV1AznKvFbuMkJpT3mPp4tMkLotMGZ7qf6DWq+AY3DFJalPFCY5vw+e1BNaf+uvwT3nRxl3qhL7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771634795; c=relaxed/simple;
	bh=5IbU19OKggL4Bakw8Gbvyo7VGD0euWvWbstZilBDWss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p7+cGqXGCYT3gR/iU4WO0NSU+iQkM/pSvIfMpXP/2bGxE5OyoT6NYbzIDRq1fUd3E8LUxRE9v4llX9l3tBA1l02L8B0lAnK1s6CEUS29gcrHsUuBtSu2R4GE2LpgjhguVA8I4blZeTblhgJBwkM+1yG4Utp7+2AgTQ9umAuSgog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iBolUUA0; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-59ddf02b00aso3254676e87.0
        for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 16:46:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771634792; cv=none;
        d=google.com; s=arc-20240605;
        b=WBDWMASqX9Gs8V3qZjQGVNEdL0w4rKnnespInYNbYmJj2P0UT49Igfiy0Y/umid68T
         2TphfTLYsFBh5GSNeuAHRQJxM8c/gi/Xvp6qQFlIjFcWPmIp4zrVsz5cpN086gVA2MWH
         HLS+biUAcCibTXKbLK6mwOd60xGL1f67sQHXlbQFXsoP/2l0okHViA1h4POFaREk1fB7
         oxW0EkrVv0CQQHOX0DLO1zSV/hsSaN82D4sIFvk/seqnwwxjPwH/X+wBkhQPhZ6J+oO3
         j7dSKDMDp/6NN3829MC1QBlKz9ArhE4OgB+ekqFdXghITJTl65ou/uHUqMAAwm7bcZVS
         qjXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5IbU19OKggL4Bakw8Gbvyo7VGD0euWvWbstZilBDWss=;
        fh=rEM2Acew2Idq5NmQV3OuDxd/9PdowPWzD65B+7mU4go=;
        b=TlX4yA8NnMTFRzf+VgICcEoHvDp8RBEw+VxqBns6cUOZ25iaoAa2oKwh/tVLSKfuM1
         KruFQudve+l6BasDCjE6AQEqHWuEGNTdbzy7+i+BTdhRJTG14B3hvsasC7PQK08YJS6n
         ikd0p5ucXkau736CvKhXLBUA6H3g++ftnMBKV3xZpPckuQbPwY6YCqWxMbENaJGBAzFf
         wo4hm+GuexnpYIZe9yuH3/X3h5g3ub5yg2bEnuAV4Fz0PxuqXpKozdWyN7KCwvPfIb6a
         OUhFz0oOyFWimFE+C5NzUIUHdD52dM6yA35iWHI6TpQfjjNdF3WZpIWVGw2rQOpHRV8l
         zzdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771634792; x=1772239592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5IbU19OKggL4Bakw8Gbvyo7VGD0euWvWbstZilBDWss=;
        b=iBolUUA01KqXQc/MJiieyPN58OCqrXFlyDzYCgJWS4lqHpR9bnIZQT+o4pgO6oU3ky
         CWtMT9opC7JQOqJe1dLlR06uDWjjTXNTvIKudVo6PvbZQy/KPV6DLY+X+UpNxmb3flcs
         kQpQedAt5eriHdZCzy+bp2YTtHIxKSaZz2pHJe2b5lQgqC0wRxcJtMn13rT5LAIOQ6BQ
         h71mtTaokgRf/otNQFGYO8Y8vzwSTM8yrLBzK73Ieg2Qpb0XnNUJ0KkUza5FykJoK7OS
         POlhUsy5QDMQd7s93GxgvQ6Lh0pWvkxtAeYK87rzT11LRrT+v2qHXgTKR5F7kZFJA7dS
         DG7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771634792; x=1772239592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5IbU19OKggL4Bakw8Gbvyo7VGD0euWvWbstZilBDWss=;
        b=hLoIi8cm1uuZXjoPZXRX2cz8H7+A+Fbgpjg52qBT6+8WNu14IdxO3Gsk0heK4QwkV1
         XbMrnWOg4VjWBhfkxm8Y0vmCWiVk2da7B379uvyx6kki74hr2GkPUA+AGpb7YWTeg5MR
         V5ndnRI6gfpqhMl3scTyA/3UJilIelk7kQCEvu5Y2GsAtWag4w4b0F7tMl2WRMDGzDBa
         3g9esydgCr8Jkjc1ayt5b+Ja/q3ynDTq7FJTTXoIA1ni01Ki0pi4EKNSFOPSf380Ssr0
         sh5f2DUlvIROEgm0XE0kLzcGxMNVocsVtVhwo184Prjg7O1FaAJ4oeyVbITWlQfxAjQY
         9h+Q==
X-Gm-Message-State: AOJu0Yx2B0Al3fX7x+Lu4gtZ80wwOvRH4PRYYE4SV49Z/FSDXresCQTM
	DtlR207cz2VDXPDIJibdzbee7/1MvNsc+QCo9zXw+4PRs2H6+6K9KVg/fVuMwCRKrYzmtovo9Fk
	fYF3KDcw4DAhse/6CFVIpamAOx2zbPWw=
X-Gm-Gg: AZuq6aKgARXMVfML3+O+89Cp/9oaYL313J9eW2Ov6uLDTBH0zZeAHigtjAMLMnKXvx8
	uPOa48FbAd6MAqgNnvetpnzl8lp3v8ODuUOwdIBPfZTXeTfXkhIIUWJaes/lkyVlrAaAH82CB4U
	GQwE7Hr2NnMWK68Ps9/iIHmHva0K1bbQhlQfXIBS7t6Go5rYbF/lnsFt9L01NcpKAy3AJ6wA9Il
	k5SusGu4s0yB3GrUxTcV5EbniXibhC/stEqEQWGS7C+2D5O3J3toO8ZZ9Len2bzZtu4uT9o73fo
	i5fXIH4q5HUcSIH7Qg==
X-Received: by 2002:a05:6512:3053:b0:59f:6a01:c18b with SMTP id
 2adb3069b0e04-5a0ed9a14c9mr380484e87.44.1771634792031; Fri, 20 Feb 2026
 16:46:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220183858.N4ERjFW6@linutronix.de>
In-Reply-To: <20260220183858.N4ERjFW6@linutronix.de>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 21 Feb 2026 08:45:54 +0800
X-Gm-Features: AaiRm52F9kMPZG5dzctXltqpms1a_3CCme_vjeVS2QEv974zp_Fef0Y3RMAmNu4
Message-ID: <CAL+tcoD-N9X_v10-wb2cfzKspaVukf-7A1xcaYxU-cTUYzLzhw@mail.gmail.com>
Subject: Re: [PATCH net v2] net: Drop the lock in skb_may_tx_timestamp()
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Kurt Kanzenbach <kurt@linutronix.de>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259803-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,google.com,kernel.org,linutronix.de,redhat.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,linutronix.de:email]
X-Rspamd-Queue-Id: 71F6D16B980
X-Rspamd-Action: no action

On Sat, Feb 21, 2026 at 2:40=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> skb_may_tx_timestamp() may acquire sock::sk_callback_lock. The lock must
> not be taken in IRQ context, only softirq is okay. A few drivers receive
> the timestamp via a dedicated interrupt and complete the TX timestamp
> from that handler. This will lead to a deadlock if the lock is already
> write-locked on the same CPU.
>
> Taking the lock can be avoided. The socket (pointed by the skb) will
> remain valid until the skb is released. The ->sk_socket and ->file
> member will be set to NULL once the user closes the socket which may
> happen before the timestamp arrives.
> If we happen to observe the pointer while the socket is closing but
> before the pointer is set to NULL then we may use it because both
> pointer (and the file's cred member) are RCU freed.
>
> Drop the lock. Use READ_ONCE() to obtain the individual pointer. Add a
> matching WRITE_ONCE() where the pointer are cleared.
>
> Link: https://lore.kernel.org/all/20260205145104.iWinkXHv@linutronix.de
> Fixes: b245be1f4db1a ("net-timestamp: no-payload only sysctl")
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Thanks for the fix!

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

