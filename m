Return-Path: <netdev+bounces-273662-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gM7sKL7dy2lHMAYAu9opvQ
	(envelope-from <netdev+bounces-273662-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 16:44:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 052AA36B226
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 16:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EECA03021EA3
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 14:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B0A3E51D1;
	Tue, 31 Mar 2026 14:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xk4tjCRe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453A23DD525
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 14:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774968220; cv=pass; b=LQjfbOGVP9W/sf4m5eH8brCScL9/+emyfU92tKtBMib/+VjKI/juoRxK4NEujh4+msddLvjVer4rTdX4LPVBEMHgPhSfxc/5BLEq2dbmJlSZ52gV/NhfGQVCYgFK13GpT5ALh0ueveX7PK/ZSuDM99h+Suu49Va4vWepc5ncTJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774968220; c=relaxed/simple;
	bh=NOuzXAEYn80XFyKCOxZbePqjT8NOiFxa3DmozZ9c7A8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SK/Vcfb6zjvFCbnDJXPu98toqOBCo0Qp3MObZGiVGjUVIYsifhDvWeFLdHIYBrlUwhsxqpJO3b4WyX7bp+JdA77OY40JOMJYjAzGFft2nFtPCanra/Bs4yYZTGWvRC91CFP5m03ovmFyEsPo5ti0pxo8a/N2GrZJ+8dAETE9598=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xk4tjCRe; arc=pass smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-662efd1bdd4so3297730eaf.0
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 07:43:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774968218; cv=none;
        d=google.com; s=arc-20240605;
        b=KXWcULsqRnm4PGEb/z6TkNDsuSlnTW6+FOa7fURqE64cH/TU2X9y/AbEb/5UIqdcU7
         lA1Sk29Ejq9EOJFyMc5eVe7ol4DZa5UNzvno3c/kUWAtWZwN8VYZsP745FZ6PkW4XcoA
         /8z+duMpZHkYOViJMzwRZhT+NoMMA3kFoYCBvCju1plJDzT7ipwVmTlqhz5dFiOfj6lw
         qpdPUm5gzybua/WT5gs16PH6TRO5VVBIZ+k7+pKXP//kBanSfYeCldcrxGqvzDhXFLYP
         ZdUQZunPwocAqu/xbEeothC8htCsOuTuVRYZivIk6GBma/xbdtRlS+R6bhE/vuYzeTrx
         qgNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=NOuzXAEYn80XFyKCOxZbePqjT8NOiFxa3DmozZ9c7A8=;
        fh=qYfmU7y7+v4Ba2cmjB7w1Hop8hW4hqOJz7u7hgtw0S0=;
        b=UzFp+lnPOyJPjD3EUPc1v/k4w4CRXc4agJmWXiQsufqnf4BCqqnWv8bDtUPRBFx/WO
         aVKdzecPod1e3tSk6jJHpeQAo7M4GrPOZQ0McjzhYe2Q6R4o/HIS9GjHPtWg1OHeXtzw
         TgPmt5YhQS6fWsWqMj2Otc0LMVz/x97NiknkMYUEw39kdDod/L/DOJJmYOQW9X7whLeQ
         t3VUlpkDxwzvpbSawuBF7xCU66UK9NZpBZQXGP2azkSr78k+rAQ8FHAtV7zJDNYYQUhW
         CrSMk69hZ56QYk0Yp2kaUw4KZAzi18irru1xNItP+nE7L0aak7OWOR2iP6+1KYLJ8fUQ
         Y3SA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774968218; x=1775573018; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NOuzXAEYn80XFyKCOxZbePqjT8NOiFxa3DmozZ9c7A8=;
        b=Xk4tjCReOz04odtUCxHhfQPCBQoB5oXF4vmfL51NwYyS1gao5cRDE6Tf+RyUtqbFxT
         G3aou03IRmx9OAOXqAZKHTw7wYZq2MD69wZjEZ4vw6IgpXGFo7fji8qSBBGWJKCXOUKo
         csSym2+6tO2z8q2OUMLrgLtZExR3/TjpO3jVN4R1q928rijZ13gpILEJN5Ha3cM+v59H
         dto/G7TkAo3uYfrGT/u6zLaPEKLQPgeWzdlkv9l+TGuVh3Dt98uNgZN+FqniWvaTwVCJ
         8OLAj/XXaieEXHuPHi1S2tf46qUCSILrILpoEQs1nFq9ggkIFqvwuDo0Fw+/KlNTuh4a
         lm+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774968218; x=1775573018;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NOuzXAEYn80XFyKCOxZbePqjT8NOiFxa3DmozZ9c7A8=;
        b=Rg6dpel+c8j3oTCGUTZb5vM2WXJwsF0LpF6+wu53shqrxUg35+4mST1pPmu0809vMk
         opkenR8qqxcnnWGfrSTZ9WJKNnBpmN0/bRiqTiA09iMWNgYUpnKgDM4K5leglaFmoSdx
         7z3UY+t1n1GBSLT+Ad9JFpgOuh36y7AeSmKyoYd46np4zC0ga6tsGp5knv+iIi4q1S2h
         sKEfYY0Ue1zfgk4SBvYXf482YJ/D3Un2SKQERb2eiH15U3VibYTMidlKukcGl8+ixYXD
         F93tpKYlANFtGZU60s/q9+PL/UmOD/2VZUJgXHCwOm/OI2fCO6WnL2jQhFyianE6VPFq
         Cw/w==
X-Gm-Message-State: AOJu0YzPbzrvdiFeeXNAky2/lw2tRVdQqofGY8QfgmrThVfJWKpajEsB
	0AHwPlrxUeq5Qjn9RRmwYEBRVcdviIDXgiDqR/vzRfS1NbKifV5FCEYFwYl1fqnZxZikn29KA4f
	DZhSmOJf+ys8avxS+3XSafWk5YM/AccbnPJjorgRHsw==
X-Gm-Gg: ATEYQzz3x582yBbyXkvNq22+LL0sXAdJFyjxdKyBT5FFyXpRxXx0KwK+U7ErUfwB1bZ
	S1SQwEo5yPiHv2kyw6nXxR1t/CmwKZdz9cXl2PmiArHsOobv3u8wh4NirNaoo413zV8dkfTckJT
	synS98ifOWw3T/HVml9rLTvaLXkKRMi7hUUILviSiy66nbG9Zhl7nxNvOGBACUBBVmWVaY4zQCl
	fS+qsDw/S5Y4pz82amHLSMq8NFbJ31aybirhcfFC3ojIrZOhKDAe7w5sOAXCI3lpKtROKR7ktRp
	G/aizH8ZQPHtC011m60bs9St4JvUfRE/4svY7ml/bymLzTMj3Sq6ZRUpBeSHLhTrXA==
X-Received: by 2002:a05:6820:1a85:b0:67e:3d3e:db54 with SMTP id
 006d021491bc7-67e3d5ebb53mr1616780eaf.0.1774968218024; Tue, 31 Mar 2026
 07:43:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260328213338.450601-1-nickgarlis@gmail.com>
In-Reply-To: <20260328213338.450601-1-nickgarlis@gmail.com>
From: Nikolaos Gkarlis <nickgarlis@gmail.com>
Date: Tue, 31 Mar 2026 16:43:26 +0200
X-Gm-Features: AQROBzBEhCV3vJQ3eRT-hpY3o6grEvXRE3D20pRSLVkNMQexEsMIkakvJKZQJCg
Message-ID: <CA+jwDRnZnPyRZK36nQ2jjjzz5g4ZZNQw4rTkPb1G+QqLWH3SzA@mail.gmail.com>
Subject: Re: [PATCH net v4] rtnetlink: add missing netlink_ns_capable() check
 for peer netns
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, kuniyu@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273662-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nickgarlis@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 052AA36B226
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Just following up on this patch; is it okay as is, or does anything
need to be addressed?

Thanks.

