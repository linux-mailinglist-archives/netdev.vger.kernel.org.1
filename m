Return-Path: <netdev+bounces-288078-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCnmGM4sBmpsfwIAu9opvQ
	(envelope-from <netdev+bounces-288078-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 22:13:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C134B546A80
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 22:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4DB30300D94C
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 20:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059DE3BA222;
	Thu, 14 May 2026 20:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MN+xZP4n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B0533F58A
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 20:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778789515; cv=pass; b=JNVzaGk2Ye8P+glRvXE/wITks84owOA3L69WFoYzA5xHjwE+MW2O1UJi8AjTR0YGuj64PJnJLk/F/LyCEpovV3MpOkhLBsomuFtsJQhINhu7H/JrqrSIcqlwHLHL/NUpCicyPrLQrbWEw4zmxcdRJDMdODWVryvXx3xQ33WsmSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778789515; c=relaxed/simple;
	bh=ECtYCvo02ZhlheHGOoRtA8r4XG5dlgP+fN2EX6N/aj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FU1IJ7YIiYMNmtlsdUHeCZ2kB1pp3HafuFUMv2kW3yuwhMJUIpVTSUcBiDQsqTZrwOLaXIZMb6FEuctaN2GWTdiE34D4OL1dLPNzAi0AhVudYRGVuJAzpzDhi6wNqZyTzHoVgl/igBGAumaUvGKpWaSKD24MN+b2dhuiIIMDPfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MN+xZP4n; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-651bc83e74aso10747597d50.2
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 13:11:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778789514; cv=none;
        d=google.com; s=arc-20240605;
        b=SMSWed9sfybzyoOAGFwB7SdQiNQ47ZUWOX7r7+qZ2uVdZHH+994lHQPqKLg5mW36GE
         llmQPf9WNVpFPIJhh8waCdvdjDemw4LQmHh+H05omBA269yURhJL2ronZmo2uWFl0Rq1
         6UefPrfoN3L1dHz12HeQJvFt5rcCIGL4JiBj5FbSPRSBLJ2ob0xk+hLhJx2+KHjfsx4P
         5732WabhKYUA+lHaGRtb+TGq27Bcd/fdwC7tV0CEOMaycI+7ekKeWAlLFqoa/4qChFAB
         yCwTy9cE2UPtRF0laxACX5CotXchmTxaItsgZdjEY4SiuiVM3foaVCG4kFmdVo3h/c31
         argQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WkRoEq3An5kpNwW0LemtPxgJ1D19p5rGsNRCE5PMwmQ=;
        fh=WYWgqbY+XnrDaME0x+XmYCn9Cq/6Eqs3wQU4iTE45E8=;
        b=Ovw0pTGHIPU6RK3etduaI6Lsl05SLUUDIASrA4n7L5wk+YjIrwHNUZYzLka/kND69J
         246Phe6Z/ZInyOMW41ZSExcmZJQ3hjdzHIKJaHmvVptj8Yb0lx5OH+HeXHkeduC4UoQ2
         9cuSpZdmLitQ7LRCInYBj0K3po2O110Dr39zPGq0ZjaOO0VDThCyUizKwENccUlRINAP
         69M+cfuvEUDA9eMqyV40oYxclPAbNpfH5cERLUd+AiUgOQU/VHmOBHWclAQl7T9eylMz
         qeRDVG+qICb7e6elbCa9Q4GJwgkAunWFpiID55BaZLWe/cokbzHTeogo4/1+SG6ApbnH
         ogGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778789514; x=1779394314; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WkRoEq3An5kpNwW0LemtPxgJ1D19p5rGsNRCE5PMwmQ=;
        b=MN+xZP4n40rPr3lI3v+AewyFLQjABbfZh2+nL5PexP90Yf6UF3st/nFpbRkOFUXzSp
         lbu+VOaEU8jZE5VUfluUD+b4gAhpbshgKj6aBODO5uDHgLdUBPQGOCX0fxMPHzdBlgyU
         Lx1LRkaoMJZ3ifQe9srR7MaUrKPT7NkdE6sU6Bx8/dAKwGYkRD5NC+/kh4o9WUG7bZf5
         siEecVDxbPUsGegY1MQn3yd8Mw6Bt0he8Iby4WOyWGXTjUl4ogQJ7sxsbs4lkIiqhyaG
         Rwzrbrd0xGhWpk7QpjR4X/IW0UVYaBJSDa0jcCv6z9N0Tv9uCaDkD2Aathzvx/bF4BO1
         r1tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778789514; x=1779394314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WkRoEq3An5kpNwW0LemtPxgJ1D19p5rGsNRCE5PMwmQ=;
        b=OuDvvBWtInAlcmjusAp9S/apzWbIF+gVL5UZZOIDEEtZllW6zKz3mge3i1Fo3YqJeW
         VpmNpph2MiW3EmR/AS43b6dfI7jCBCfflwvDmdgW91DovIL51qwUSLSHcBwQmOiUw0T7
         nInhGOEJyeot7hekn3JBpqROTHM6kBsKEjjuJqW3oHGmfC5hErLCDs/fJEcH7eLb6RRD
         krjPHqbdigHg3BQ7MvJmv79dmaDfXSB2ZM73tMrBlJXwxhY3dFW+Zgt9bBXWGrl5MNoW
         oQoZlUUAfmrWrzEANYyaZxrEn2WHeV3Zac7LERPYXdlHI6NbITdvsxz3iH/lyAYgGyRt
         /kYQ==
X-Forwarded-Encrypted: i=1; AFNElJ8XNIe7vQ2QAtjeMbc6J9fhrl6OjPBgqhBBtxdwdItyZgDbFWIehjH8l/oXWN1v6p9QvYUiUFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YziwGq6AXnB6V0l9qjae/KsgEMWe21ow0be3DraOjpgFn3H9T8B
	ca3/uigiGd9IHwPPbPAYyp1XC57DDHhDRhAJBQV1vZSV42S/qysGiS2hNFkb+CLMF16oCCMCB3L
	iSF2xc5yPLRBXF8LrkLP9m3IanBRo2Z4N9ehe
X-Gm-Gg: Acq92OHSnAI8Si3jMUrd/XwcilIJOZQTsBAqTamaT79j7IpJMTJq0EEP8xfa6W6Pbfu
	6e1obn8q41sFukx1BVYz2yl48GP6E4+Tdfq21j9cz7HjYQbSOyAFuG5LCxrvb5J/b7JuiXfCdwz
	hh3EYo69SuGHMCpo2HzIUZG9XpivsnheBLmYYqzoPYSI4HvjGCxqxo5I9GgGyvLMr6V5qPy6LUL
	yo4cNotCXdwfXofmM0DXj2aLE22rcVq0NLh3Ud2cB8U3CsDiVdBJdWvBuqV8/sKDhgwsFFCbzoF
	kP/STaXmiV3FwJwt7mU/prY2KiBjATvYYu3LJvCC2eE3wfydurEtUpVo4A==
X-Received: by 2002:a53:d059:0:20b0:65e:197f:867a with SMTP id
 956f58d0204a3-65e228ea8d4mr719060d50.65.1778789513537; Thu, 14 May 2026
 13:11:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260422160342.1975093-1-michael.bommarito@gmail.com>
 <aej66UTWzQ74dven@home.paul.comp> <CAJJ9bXyoAND+CzLqY=jGWdtaY33jeLWf0sBbj-6OXHyXudqjUQ@mail.gmail.com>
 <agMdXKQgo3jEWtXN@home.paul.comp>
In-Reply-To: <agMdXKQgo3jEWtXN@home.paul.comp>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Thu, 14 May 2026 16:11:42 -0400
X-Gm-Features: AVHnY4LhK0TFEDWN3OJnTVdmb1tsHH_TNQ5AwtKE-q0xTKxzhj4wLIHRwgPjMVc
Message-ID: <CAJJ9bXw4ipOJRnqO4ZvaYh5wk04XpTq9r5gcbeyGs5-SHzXKdQ@mail.gmail.com>
Subject: Re: [PATCH net 0/6] net/ncsi: harden packet parsing against malformed
 BMC replies
To: Paul Fertser <fercerpav@gmail.com>
Cc: Samuel Mendoza-Jonas <sam@mendozajonas.com>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: C134B546A80
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288078-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 8:30=E2=80=AFAM Paul Fertser <fercerpav@gmail.com> =
wrote:
> So I see you got some interesting AI-generated review from the net
> maintainer Jakub on 23rd Apr. That raises many important points so
> please take time to go through them manually and respond. Once some
> sort of consensus is reached feel free to send a v2.

Hi Paul,
Thanks for the reminder!  I did some more homework after your comments
and started to dust off an old PowerEdge 1U in the basement to
properly test this, but realized that iDRAC probably won't give me
much to go on.  Do you have any recommendations about how best to test
this before I ship another turn?

Thanks,
Mike

