Return-Path: <netdev+bounces-265106-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBXVHYjLq2n7gwEAu9opvQ
	(envelope-from <netdev+bounces-265106-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 07:54:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DAEF22A84F
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 07:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 87D7830005A9
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 06:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30EAA376BF2;
	Sat,  7 Mar 2026 06:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hK1XjJ+4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40889368972
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 06:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772866432; cv=pass; b=Z5KeK0hjbTWkMyAsRSu6QpQL7dop1gnSaTNt3NAFV2mw5WdvRjBsHAI+0iWZzR28mnu0TpUzOk3yR9MeGIgCLZ/fZrYaFiKG3obikkSZYruM3LN70y3c+rqd/E1xsuafcjhr1Ph4ybsIvpKYxDJJ9avUhuv6KHgGm+hLO8ULZLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772866432; c=relaxed/simple;
	bh=icsl/YTr4fZbb0OxrSi9kUnwufOmLm2RUbcyua4fIKY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=JJ3Tf9vmlT7cyQ5uT9NSkoTFGy347CJsX5Nv3bcUjxIJplrahpfwQB9am9W8H+QUR8rIe1JfmQfrZluwUjEIAh4Ys5EO8Mql5g37AixutPIhWFROBXOTsirY8Qf2PstOylmCf2BLNi+tcynkr8+uY3oRaxzMveac+Y1jy2hJeZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hK1XjJ+4; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6615c461d3fso3760834a12.2
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 22:53:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772866428; cv=none;
        d=google.com; s=arc-20240605;
        b=ZWP3FAEGvnvM63mz9+vctfRnZSVKxHd5jrVtwqjSrx3ri0+8SI0msFwFODdV6hW5cp
         Chr8LSFGK4WXDbIeI+eLUZ7dPnmcvxnZYYNsilaS2W4cclJ9IhPBfWP8YP0I2isgCVrs
         4ERWRaJhtuNkaaHBLMldTQRjttpfdCPnrkVUH89o/YS5xblyosfyd+AulktXjecuLxn5
         y6asASFf3pMFcuEbmwR+umDcqEtbbrrpiuWJr7kFNjX7mqtPWtHfPj73skgogXqJ+zzT
         0fEcCSOhBvGrRpWOb07Zu3u9O40Re+IcFepZScSYTOrVzagKv0OHsinUvHCcSZOScEV9
         t0EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=icsl/YTr4fZbb0OxrSi9kUnwufOmLm2RUbcyua4fIKY=;
        fh=aDUZZ9N6NPmO6DMPx8G1ADwl9DVnQFUvUJ2oivftvxg=;
        b=YUJ7b7dnMOa9Eb3vwfGNo34n07FaRbpJKuud10UqWP2BD1V9XuaHNkYWxxaYmCArtT
         rRxj/jsCRyo9CJi1VvBNvqX1vwU3wAKIGtdbcSa1IO6soc3Sw8vy3Ho5mMem6i046Iyp
         6npHzQvX0vmqXmtOCWAV9GQPaq6rWm+3hOXimFZgdwMat7VhNYRFjFN5qRkK7+upiaov
         KfJ49YrTMivbFdP1MrW0lfaAhWk3hRyTTLdtTUvunuCsUi6VUiGO/w69P3asvClzHMJs
         ihnhxQidFnPpgEGwTKCdSU1BGc9Wy6cUFFL6NmWgspsqrWDwbXgwQfKXHWgZGKNDODxq
         r8Mg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772866428; x=1773471228; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=icsl/YTr4fZbb0OxrSi9kUnwufOmLm2RUbcyua4fIKY=;
        b=hK1XjJ+4Yq6cVOceBWjxKK72vPuQ59u7O5G0UswVGYMqN9RdLkSV7Qmn/FK895Sh7u
         uoknI2lG5gLDF+MG66ZJeDJtUe4sxxUDTYSfsKn0SzitP+hE2ajeduib1c+bXG/DtX34
         RV/P0y1EfSBifaEs39IbtzYaHwPWLMapA1XAshZujanHS7FLMRX64ZhpAYZx3PpBzO19
         g2TfWrtloyJdYsCTZfRw/U7awJgJ2ZA9NVObJeH9k50c/FJoybC1wdQrHmL/rSGXSDF3
         yNdYbQMyMB3ouFa5l4md3ntAj2AqKKvjAou3aGF8jYDXDRSKyjkV8dK9fD9toYKgdJBV
         yOCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772866428; x=1773471228;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=icsl/YTr4fZbb0OxrSi9kUnwufOmLm2RUbcyua4fIKY=;
        b=wyoj/ql6AZUQvP6bo7ykQ6CBVRucSnGtsd1ah2fB0UpM+T9qZh473bpCFU7vY3/kqv
         PURJ/ldoMpRcQAmA3FYDahFXyi8o9Db4I7A0/zBFH0A1DEIBRDu3ZoLs7ReHUswOrpy1
         6j67WxgrPPNjMrWAc+g34dN4Ljji4dcnaljMCgimZZHf7dsQxUEuEazYXcGSZNNDNVFE
         YHW8Wnf/eg7nkn3cXNwmxZmXqMzi9+Sp0uERKGDp8Ogx4uB24AUTOw74APibj/sML5bj
         Aa+YPQWIqCISiSOBaxm/VL/9jbyUExlnZva1hlc5hVNDgqRkSuTkI3JVKHEqKaD2vE3t
         UXTg==
X-Gm-Message-State: AOJu0YwfmojUNxKPvRTri0GZtX9evQ1ecnURV0S7B2HLq5TGB4fikvEn
	XuO+4gLXLThraCCzBHyKy8w1/J52NAlTfofPwBJr9ooeM+u3j+246srNLHSXJdcm8lrg3B+6cUb
	S59L72CRWiHPJaFS4I2v91NtQhF+fQQPZ/7yN
X-Gm-Gg: ATEYQzxUGPeGp9x7Ko4O/poXsQ8+34PHr99RSKH9YAZxG6iU0wHHrX3JQXrQ/wmeLHN
	+YHcqHtq6LOB2bPADYFVprY46TMzI2yRnYJu8I2Ds6BESxr5Fl1pwvp5MsxulIMkgaXxoUoVEVf
	3eedMf4GsI8xS5Ov3GnG1S0APUGUcRIIuk3yXIu/Jec5cJ0GV519KQLnAbOTEGnw6no2wJsBz/R
	fXDWSBr51jPbLDMzClCjXfDRtqvPXHmpW3NlxUv1RFcWom2/LtrJi7Bfxd8hSXQtIdQQv/PBufo
	MqClw1cSF0dIHXqCEDc=
X-Received: by 2002:a17:907:8dc3:b0:b87:1741:a484 with SMTP id
 a640c23a62f3a-b942e0f391bmr257941966b.43.1772866428070; Fri, 06 Mar 2026
 22:53:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Zoltan Boszormenyi <zboszor@gmail.com>
Date: Sat, 7 Mar 2026 07:53:37 +0100
X-Gm-Features: AaiRm52oApQxPA_933l6yCyCax0-bXqz9r7twsr13mebquFeMVbciV5bsQ8e6IM
Message-ID: <CAPeTZW8Qe7+gunv2_rhyMQUyXj7aUfVtJcSUENnaWBYYMBq4DA@mail.gmail.com>
Subject: Realtek 8157/8159 support in r8152
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 7DAEF22A84F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-265106-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zboszor@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.967];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi,

I recently bought a 10Gbit USB network device.
It shows the USB ID 0bda:815a for which Google says it's an rtl8159.

The cdc_ncm driver is loaded for this device out of the box with 6.19.6,
but ethtool says that it runs at 4294Mb/sec speed and shows no actual
phy identification for supported speeds, etc.

I looked at the sources of the vendor driver version 2.21.4 and
it lists this USB ID as supported, and for that matter, a couple of
others that are missing from the upstream kernel driver,
for older chips as well, and for the new 8157 (5Gbit) and 8159 (10Gbit)
devices.

Please, add support for these devices to r8152 soon.

Thank you in advance,
Zolt=C3=A1n B=C3=B6sz=C3=B6rm=C3=A9nyi

