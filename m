Return-Path: <netdev+bounces-257487-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNaRJ32dhWlKEAQAu9opvQ
	(envelope-from <netdev+bounces-257487-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 08:51:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E7DFB204
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 08:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90D8630252B1
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 07:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E19D3451DC;
	Fri,  6 Feb 2026 07:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mX51pSff"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4F03451B0
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 07:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770364251; cv=pass; b=djwzrCloE63Km+4GYJWeT4X1nUSmn1kwiq0mx9Rf3N1jdSg0bxdb697gJauzjaPai4v79gbMe/aOfcMFT6B5jrF9eIfDP90T32b3sdFzq5IsuJT3wO1Y+cOnguBhlrzs7cJfwMeVkN9Imofj0QJFxKXHHR8APPBZDXjSRCT6Jy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770364251; c=relaxed/simple;
	bh=B3hAMSUWNfpX4DpiYAUJiKFr0EBICwJ7tiGUDrWH+G8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gHcQPS5uQMDVrJoQI9GDWxKtE6s6QU27ZMta97Zo6+CxBA4Pug/L4VwY9S6WNwAPv33HO9Gefi9NFtdyNq/xX+tMPZwkqCjBG/WXlF5XhmnI2p8jZxEH2rMjX+L5ODAqMW3MK/NfBZXzRn3VKTdlFQLsvJ2yCVnmwlcQDt/WjNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mX51pSff; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-59e0d5c446cso2245342e87.0
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 23:50:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770364249; cv=none;
        d=google.com; s=arc-20240605;
        b=Oqg4vGBIzrou+Fm6/nwo8z7lAGW/bpUJB3xlKajR7l4N1efr4FevjU9e/ba5ri6b5d
         l0Vq2fP2fKersUyFQEJeelNKw8z4nloGQT2GQfQv3julxzoHTHNguZbahBDbJJmKTrDq
         s9B4cnmkaScLWiz+bst9RInx1EcNCA8jdnBV5m4IeUDy0qJ2OR/ahMhm5ffUl4tLpNu6
         Pm94Mhb4XRIH9zEdYrXN+rGuZxwyWy3FgGhW1PbdJOZCj5sDvDyXTuxHJKvVT1dHbnzb
         NN/XBOOV+Ods4xIbzn8SYrLssynzGQbdxlNQMHnX1QUfwmIpz1YkPY/Fvb5ZILM0TF29
         LIcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=B3hAMSUWNfpX4DpiYAUJiKFr0EBICwJ7tiGUDrWH+G8=;
        fh=2wco9K6sylMT0HU3LBh9Zx75BcvkMUh+Q2SL79kjHgU=;
        b=IHJ9w5y5u4TJnI2Ybe1eE7L2pB2gArPmDr/e/uWb/gdNrCCs+NmBe+GSBXg2vm4pbr
         VCfs4gc7qZhJsxGl5mF5gJxCfYvzMIlScwOAZKw5Rpbob2uyymc499n6mF7vZka4HkpX
         cmc5zvXhrXc1YOsP1/n9u0iUWbkidVTfVhH/U1+0vQmJWMwizf/bCYE3viEcMi7dkWBW
         afYwcDFvAthTHy9eEPXnIaLEQlRafVm4johPHHcH7gYV2dwhga9w8TfaRz5Vd79UE51e
         V0Tmth0fJtvYnC6JVZ7n2jJ/cRrBDvDgPiB7c3aHLgLNQ+iz6D0RLEbJLyehrqLOr0+/
         SR5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770364249; x=1770969049; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B3hAMSUWNfpX4DpiYAUJiKFr0EBICwJ7tiGUDrWH+G8=;
        b=mX51pSffT6bRDcI3DwqU4lmjPf37RGsiaSd+ik64DxH0ptIuS37BiHRz2WRxXHi6Ji
         92MjqdpK/MJBWFjzZ1Z/kzgeKal3vHzrP7t07Ifc8FdXLACuxBuBZH2TYzGlGf9LLu7X
         W17rCy1KM5ZBwt1UbQdSgM8HJIjywBYULmB0jVgDOypgYbtrkLE6J0jbEoKTuFJ78sSN
         OjFrpOVElRj1A7nRFRVwQrEfClY4TthnS5NKAcyXIPjEu5nkOaMEggWKHXRmsi6xvP+M
         9rCYnb6VcGNDn1RM1ysUO/etqWqjaKBFz49wqxAxJKKQwc6mpBpniIQ3auFAlILpvoVq
         1Clg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770364249; x=1770969049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B3hAMSUWNfpX4DpiYAUJiKFr0EBICwJ7tiGUDrWH+G8=;
        b=Mp9BD5+HIsRgfz6MIQWQ0pcJE6/i47vctpAmCsQxafOe4ON7wOAwmLb4NcaMah46r/
         TiLPXaZxlfJmvtJzdzWX6c+Tsjslbddgr7Erzx31ud9fYdvpshi/JBusDFFdZpLRH182
         4H1dT9Fof4CHzhSX6bSnDnD1Vjww8G8AvcqPIl2PO+vdc0oHapmH9fQrHqHWERnK1bRg
         MDugjp/eSiPwyfblrw23xnJUkO9Y3X+qE/CusiXSTBw9IlpEhDifuHOgyLNNcduN6roN
         yx0/kUEjsemLXpTjY1jVkAzVyG+DLwDfFfbeBHzsxd9+4KQRhI0dUtA71XaC20rYfAnU
         1TLw==
X-Gm-Message-State: AOJu0Yyz6WZ2s2Mi3TNT0TlJz34JLqxjSoz9Oo6OapwGexa3PREf0QMR
	Z0MtwdodAiY6q62m8UiLd4f/L8JiB61LYbg7neHW4DpDP7vTYun5zC0JWk8T5UrOpHI82EJEKFr
	kuPHwq4SOupzpT94hubUKNjKKHN8H2Ug=
X-Gm-Gg: AZuq6aIaL/VGWvUenvtx192ARo1U/QXbmlxZ3SuxkSprsPsRDo6t0nAD5uvDMPJe3lY
	r8jjrEc6/SxegcLSNhwEE2wvJBMnxfOT6rouNkkhAa6wJjI3UcUEQLaTJFNqYs5fR77ZoZD9NoW
	wunoE2EjGYwcndKmoglQXIWW21Y3dKJ9+3XKXfSxjaAOQqzB7r5Wyhfzm1AQytWNSTyjcH7N+so
	EcsIX0SAwci+harygvO1RLXCjvdW3+KtVILiPcLiNzoT8BAak3hrc0wn/LW+XRqydKTI/qk
X-Received: by 2002:a05:6512:10d1:b0:59e:479:917d with SMTP id
 2adb3069b0e04-59e45159ee8mr565999e87.27.1770364248933; Thu, 05 Feb 2026
 23:50:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205001935.11562-1-nikhil.rao@amd.com> <20260205001935.11562-3-nikhil.rao@amd.com>
In-Reply-To: <20260205001935.11562-3-nikhil.rao@amd.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 6 Feb 2026 15:50:11 +0800
X-Gm-Features: AZwV_Qi7A6M9qLEjNUiYILcOFgX10A51HfDScO3qxVefGJhgup0_o0wRoUaFOvM
Message-ID: <CAL+tcoDaV6-iLTjgGeithcsr0rbBDMevc98MoCcn2Dnn+Zb0kg@mail.gmail.com>
Subject: Re: [PATCH net 2/2] xsk: Fix zero-copy AF_XDP fragment drop
To: "Nikhil P. Rao" <nikhil.rao@amd.com>
Cc: netdev@vger.kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, sdf@fomichev.me, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-257487-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F1E7DFB204
X-Rspamd-Action: no action

Hi Nikhil,

On Thu, Feb 5, 2026 at 8:20=E2=80=AFAM Nikhil P. Rao <nikhil.rao@amd.com> w=
rote:
>
> AF_XDP should ensure that only a complete packet is sent to application.
> In the zero-copy case, if the Rx queue gets full as fragments are being
> enqueued, the remaining fragments are dropped.
>
> Add a check to ensure that the Rx queue has enough space for all
> fragments of a packet before starting to enqueue them.
>
> Fixes: 24ea50127ecf ("xsk: support mbuf on ZC RX")
> Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>

After resolving the issues that the robot reported, please make sure
to CC me once the next version is ready.

I nearly miss this series buried in a huge pile of emails.

Thanks,
Jason

