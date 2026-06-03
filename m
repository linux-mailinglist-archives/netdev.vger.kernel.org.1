Return-Path: <netdev+bounces-294607-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lNSxBA7YH2q6qwAAu9opvQ
	(envelope-from <netdev+bounces-294607-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 09:30:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07456635393
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 09:30:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=TkEdKU+q;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294607-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294607-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6FB253028635
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 07:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E083955E2;
	Wed,  3 Jun 2026 07:11:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD312D0625
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 07:11:16 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780470677; cv=pass; b=g9CqrjvjSOw1+gPBWXIb6Oxpxr053k9SZqWibueK23bKcuUM1SkcUDecuTv1o0L/MflMNdOkW/6RQj6xI6LrAvB35+A5OvNSiSwHZfxJoQ4N5pWVvkDXEDNmsUkTafMnNJ8SG19Kk13z6XaH3QyrH6AUFPOdNoUm0wd2wDJLfx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780470677; c=relaxed/simple;
	bh=O2DKWrs6lCT2ta1wPdKxbvu+lCVqJw/cinJez9p6ZDA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qSghhYiPTcIv/rIDFdHQjashKsWMkswA/mcZ8PfinpBuUlkvPs1T7YP6QsnEoJvUGk7TzanaG5Oek2Ti53ACzaWQOgV9ahir6QR4kxhs2cTKDlvqeq19h2utFn/c8nm2EUSd+W8sOseBd5BGN3UXcyCmZQC/pb6nEOHp4qCslpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TkEdKU+q; arc=pass smtp.client-ip=209.85.222.181
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-914bfa75911so43244885a.1
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 00:11:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780470675; cv=none;
        d=google.com; s=arc-20240605;
        b=DHBJItkMv7ZDg4iShHi4e1Arz5wQnPWqfZfdHVWYKM1Fhpbrb6uQtDaBC5bKhQiqgl
         mYUPo7f5i2hPqs9JwFEmqNGRu4OogKX9hLmOdqF39QaU9+1CuvVgKOdD1Fr8n5Ygt9tF
         hWlLC9ClNeMwv5Aj/tD4Vopo6dmP7VwCiXX5tvXrlOblHoir56hB/8MRUm9vIgANEeLF
         evsyObnEDl3BY9jjvueZk33GxdiQYS2Jh713MTvIuJHEA6Vv7JmqDSztwHb74rnfw6uq
         aacgysvcgtooidMX79u6baOrFwUWFAqUgR1btd44fadsZMjCZzCdvud/CXSW5gmdqiJD
         NzWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=O2DKWrs6lCT2ta1wPdKxbvu+lCVqJw/cinJez9p6ZDA=;
        fh=5mIYtaljc7DkLS7y7NFzE/SNwLtqQCK/Iw0MdsX8SzU=;
        b=fqQdByTQR2fMqIphUFlDQicsQxILUnfsSgrHEXnbYEyiIcT5o8O+jgcmAND187c/ki
         rrcLF5jOBHgiXUG/YcZmSv8AGNa0nfJVGvRl+ZgeXJ1whF3ZLujtjfDDbXHVBaCCIT8L
         DzqLx901PnyV27V3j+dgQrAEvOhMDWygmspOwGiI4SpwrBm8SjPZnumccopJQQSvsNR5
         tEhCwYx4qcBpK6a5NtaP/fsTdMVi5sALatqw/gHITPbB+AhjTknBxKIJ1sRkS/KxNI/P
         8iTYtAZG/LLlvQ5YwKADDKgyryNnkTwXeJWfaMPfmLVNzhW2m0AwjRJmXoKGXR/tP5Il
         /y9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780470675; x=1781075475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O2DKWrs6lCT2ta1wPdKxbvu+lCVqJw/cinJez9p6ZDA=;
        b=TkEdKU+q9P3S66nHVfM+pDsE8tcSaia8jmjDL34TE3sF6FhnG2HHVfGhFmwuempGsq
         D1kR1rJ1gPnU8TfQPHGS0D/DAp8b9mOGgrJ7nBkN3pu6x9S/uGYJOReBQBKdTQZn+ET7
         4x2WLUeV7nSWp0yMHqixjKdX47St7AU42qWy5AtAjTl3piuDcXsAoxK1yOAUV/xSCFDW
         F41saPedcdQJIRk8+QbeaXtNDkvSaFIprmOVhvheThXZ42hCelfaWOhNsUzmhmSH3JHP
         1ocyTDLSHPVKDb+SGUU8sN/poIZMqOTKPtEUQS+vVf9Z1/973/o/jMqsDfwicwLVwZvS
         mH8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780470675; x=1781075475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O2DKWrs6lCT2ta1wPdKxbvu+lCVqJw/cinJez9p6ZDA=;
        b=JI2sGNkD6vqc1qn49Qr4jRd13Ao64EUVparRU3bmQlEAPegRInE7FFjNwmsv0+BIe1
         Zog7n16Pn0lz+AAG+oVzhBOZjo/LDN1wfq+NjRhZ460an/wFAS22EsfTiYF15nl/7Os5
         /IiURMaJSwdbPji8ig634UvgQDpj2lU3UklWHqwB8Q5JRo0ozccRNGRNfyN34oi20p8i
         CPa9rErg4WX2+Ds2nRfBSxYr2Bz/Q/8ZXg18lB3aKazrOblFE2F8mjx2AtthETTxH07b
         +76sVme6YObyo6duXYd+54/lkGC04jWYt7Nn0vBGr1nWWZ38ytTsnbmuOa3rZothQy5e
         TTIQ==
X-Forwarded-Encrypted: i=1; AFNElJ8EPYNUgY+G2xpYaBmlALncG5QBrDNkR2zFT3eh+TV28GHfbzbAXaWIDMuQ0MLWkyiCfsjy4AQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG69F/rhgVMMDCdrDqRDmEMiz8CzRzUmW/DfLxe1WKC3q7JfuT
	7Dg4yyvygosHyN5P1JmKu8e/72mW7RcdJTEh3LNHYi64j/xXLA3DMLfeut2VmSRcN3NLR8b9duQ
	kMcdYz0AYLd5/RT13VYzxzvDrKdMtOeJDvZqRmio+
X-Gm-Gg: Acq92OEo6R7F+Ma7/cV8P7DBuF6bAMdNghpaAVHs0NRo7ZU+lUiQA5hJZl5cQ+5LWBO
	N2u75gj/+ArzTv+ptdF/n3AKEn4DLD2DwOqyc7XC0tUjz5dNGdYM1dfRbmjKBftG/2yoVNEiOO+
	L87H/zqTv08D6stpECzVdRzMNjV+HJON0ggEsPul81RQRmC8llx8awQgmp77t9RWWXxH8NHwPdC
	H+Dy5GqxIu9JENNwlGrhvKR162gJifyXR4O21f5dQleMy/Lu1K/plTKWIFRjfy/ZhB435M1sU/9
	ykrZImuRIGNuMM/hIM37tWaBBIlpMEQ3Rdnry6ykZ255fJosVvk/L1n0LUa6QrVGlGiJ14OfexQ
	CFK03a16ZxZZXvxm33XOFVBu0jBTy
X-Received: by 2002:a05:620a:4728:b0:914:b497:c5f0 with SMTP id
 af79cd13be357-9158b6e1c3amr244238585a.26.1780470674639; Wed, 03 Jun 2026
 00:11:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603065323.2736839-1-yuan.gao@ucloud.cn>
In-Reply-To: <20260603065323.2736839-1-yuan.gao@ucloud.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 3 Jun 2026 00:11:03 -0700
X-Gm-Features: AVHnY4IUrdN0V9O1ZMgC9U_I2n8gDKGpt0dfgReWYKcHs1lWYXI5SjJcEbq_smc
Message-ID: <CANn89i+AC6VvQfh8Nyi-rh2PfhdcJZcCiMFRB=yfUeBroaa=Ag@mail.gmail.com>
Subject: Re: [PATCH net] inet: frags: remove redundant assignment in inet_frag_reasm_prepare()
To: "yuan.gao" <yuan.gao@ucloud.cn>
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294607-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:yuan.gao@ucloud.cn,m:dsahern@kernel.org,m:idosch@nvidia.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ucloud.cn:email,vger.kernel.org:from_smtp,mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 07456635393

On Tue, Jun 2, 2026 at 11:54=E2=80=AFPM yuan.gao <yuan.gao@ucloud.cn> wrote=
:
>
> The assignment is redundant because skb_clone() already copies skb->cb.
>
> Remove the unnecessary code.
>

This looks like a net-next candidate to me.

