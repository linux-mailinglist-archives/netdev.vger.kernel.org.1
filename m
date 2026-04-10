Return-Path: <netdev+bounces-277255-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PhvJAOR2GmNfQgAu9opvQ
	(envelope-from <netdev+bounces-277255-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 07:56:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E53223D27C8
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 07:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A91C3014974
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 05:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D7933A70F;
	Fri, 10 Apr 2026 05:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fHCIffkF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49C4336EC5
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 05:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775800575; cv=pass; b=tD+WvqyzFmqxO44cbMmrx+H9atC7UksjgIypquxXXP2KC1bmJiGPJGPLSJNjQ3sge0QcSjySpv+AChjDbNLmlKJ3FGoEkqWrhjQ5grfRd7EOwBsseev5wg7H0gJRxsHit2aIKG6MgvCCJkvGS5eNlXso6NfO8s+b2oV07GaKBCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775800575; c=relaxed/simple;
	bh=nhsMY2R6luhc7qcTB63grjO8Qh2xfLCpichqu/S4efk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PI5dOUQ7ScU88ui2vtD0nuvLy9EtuOCEBkuR4wSVbcogeqW1bTsEs94puUAEgKw9P7CGR7CQFQtJ4aGVoKMQ6y4sT6mdg36gk/mta5hdGE/o0AXl5IZ+2GDPprfuESAvu3lhjkiYDID/3bychm5rHeDDGYKX7+YdHqFZOkzsYUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fHCIffkF; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-12c080efc1eso921582c88.0
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 22:56:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775800574; cv=none;
        d=google.com; s=arc-20240605;
        b=YyOc0YhhZHIWaNaDOy4eBiMtRuWD1nbicsHz2ztD34e5lzb0lb1KNHjDqUx+DyM8YO
         qY/QV3Ehtvd/kje5OZeSo+NLOwP4HmHNCwHnH/iB8ZrCvEbrhAj4IsGHiJuKxYFWo9zj
         ApkueHxerqr8Jmc7uE0oUGv1MUwExZdV2Lv0FypdYpWPhSA2HN9yOZQaD8j0aYHoqJXt
         FDy62UNLt9HSD8J3W4/jJMsZ6mBBhMOq4PkYpRBc7VSy3nUWBoBsFog3/WgOa4a2/E6A
         rwmiYr6PsX7nPhfeIB1y0sEg0DZ2W+tz46QD708OqGhJdLtEZs0/G5owK2R9fUgRH750
         tqBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nhsMY2R6luhc7qcTB63grjO8Qh2xfLCpichqu/S4efk=;
        fh=im6dJjYEnqAhO3Wl1NtVdAgs3zwiwSPoaOGyMSR0qzQ=;
        b=bi4q+wCPYX+6PwwxA3BhTFTVgCEei8MLQBJiVkx1TOfUtrCw87UoSr0yJ9SMG+Qs3T
         yro1s6JivJVlkFInJ5oLBfGm6LvmKpr7aGsLdp4LTJLL56/Jfwb01wxUXFO3Ztc0f5Xu
         88WoU71qfhUGGouLL7txp4WsQ04cUnigMl6RnAd1Qkf1dBOhucML9jmlgfzbFTcfCuO0
         ZHAm//mmYEdp0luFsjemQKOZkWlgVI8naYo366VUJBK1ryMHyi5LRQl8MzDTXYuUY/C5
         PogD1glbJ9yZZHALl+batl3Z66ADFU5XCgjW+FjRq+RzkrEOqeSEaaZ2WLwKiXBvtBfB
         De0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775800574; x=1776405374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhsMY2R6luhc7qcTB63grjO8Qh2xfLCpichqu/S4efk=;
        b=fHCIffkFEgSitoQZwYcPBoHSgIsmNdibBjtWD0dI8qfsBHcaUpDv1y5O7+dsntg4Mj
         guaUhxgyNfgeyIpI+jHeRpkWJEYNKR55bU7KuOdEoSH69L+C4j8HQoOJkal2SjelG4fn
         a9m+ST1FJd28fp5xNFncRSG4F8vDdbw/xaXCfwqC103lbN8smO2i18gpv/HaV+ZbOzpZ
         ksr+gPQf3t4Se/QUBL8y43F6Tpc++pu+C/JM/ee0shlWybqlNfplU5BG1IHl/jrd6BoL
         Gto3M5LsN9awznVXW4ylpS2UiR32M5wu9zqJJKvqfIueKpKzRwi7xzUSucbcM+WZbYm8
         XrDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775800574; x=1776405374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nhsMY2R6luhc7qcTB63grjO8Qh2xfLCpichqu/S4efk=;
        b=npFKpH/oZQ7funBWttVpt4RuVjwF95lNc2RludQ2+URWaSDkp925kOZeh15YO+U+rt
         xZGrdsd9PdKNwTO5sgiZJFRSWkecylH1Arxe1LezNM0901W3LH8LRWOR2d5DGp5vA67r
         Id7b+RSvoZXMa6kUXyVXq5X0k5gQazkageGWvC5Rb80W2BtUNRrwSV124WToJnfdIXuq
         tbdBTdukyM/DJjmE1Zknbw153vyfGDDUvqXjAP0b6x+DscRNi790EPTPWz8rDCAuOPdN
         ETbzewvsb83Zc/6QR1lgpn/nwsXeJZxPFI/hr4DiRKr3j5cu2xpbx284oQ/dZF8eDvIV
         rLTA==
X-Forwarded-Encrypted: i=1; AJvYcCUnaxTSWj5QuQURUA3axf/iRYIiiiLPLgj32IdVAObufMJPCZP3W9g39FO3w/jBLjDqPPlkN40=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC6f0rNKYpmtVwqWp/ocsmmS6Z1x7E6XJ7hRb135FeOgVot3zx
	5l1NKuO7xs8WpcqQ1yBfW4h1ZkHRgQXvWroStpszOJILD6MFCqIiIjQ/+414c8rSf4EX3ra05aB
	07ICWRl9+g7j5tYdDK9IpuCCAXL/2L/m6zrioNtpf
X-Gm-Gg: AeBDiettCclfBpPwRzYXNrKPsDXuwAKWw55aWxN/Rzw1gg20TD142cCNqhLAuU1BDFM
	BTf/w4gg9riVlzlskktXzkAV2c9IosA+hZ/t+wdrIxgSx6ihgN8vTKynHM78tFZsRVZLMref6Xu
	Rzn3qYxA70cGjyDzvzDc3rObp8qrfD4vNYPmFsA7NUds3ps00vluAwS8E2Fv1PEOY2QZ/B2+qOG
	RmFZnLLj3lA9YQLUchWvYcc2vqpaQs0zBjZvdEQh7Q+mV1sLoduRn5lVPsluNVo/WEEMYpecAxZ
	ZP5LJjGsMk7iYrAZlZJZqjKRqB4w6VHXwURlvph8sWY3RWi9UDxJWaDrckabTaMC93g/0KkCx+s
	lRTDIfUA=
X-Received: by 2002:a05:7022:439f:b0:12c:d3b:f0eb with SMTP id
 a92af1059eb24-12c28bff23bmr2940180c88.8.1775800573242; Thu, 09 Apr 2026
 22:56:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260409-teaming-driver-internal-v7-0-f47e7589685d@google.com> <20260409-teaming-driver-internal-v7-2-f47e7589685d@google.com>
In-Reply-To: <20260409-teaming-driver-internal-v7-2-f47e7589685d@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 9 Apr 2026 22:56:02 -0700
X-Gm-Features: AQROBzA9Gpi5wED-5edeFVS5f-uLhTqN6TRfWZrNTxnIiAQrrlALwhed4PBTrdQ
Message-ID: <CAAVpQUDxnbbO7FyAyFUL1qCT_30kknVDy=mreJd7M7SgyA_YBQ@mail.gmail.com>
Subject: Re: [PATCH net-next v7 02/10] net: team: Remove unused team_mode_op, port_enabled
To: Marc Harvey <marcharvey@google.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277255-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: E53223D27C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 8, 2026 at 7:59=E2=80=AFPM Marc Harvey <marcharvey@google.com> =
wrote:
>
> This team_mode_op wasn't used by any of the team modes, so remove it.
>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Signed-off-by: Marc Harvey <marcharvey@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

