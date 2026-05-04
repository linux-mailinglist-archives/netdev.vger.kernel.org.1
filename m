Return-Path: <netdev+bounces-283860-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JbKE5ur+GnHxgIAu9opvQ
	(envelope-from <netdev+bounces-283860-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 16:22:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CC99E4BF361
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 16:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 583313089A18
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 14:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2DD3DEAC3;
	Mon,  4 May 2026 14:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKZRZ7Sz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7701ADC83
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 14:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903571; cv=pass; b=HSyOr4W5UKm8FDI5fjH/Jf+jc75IcZD4yHAbWGljlvWJqKFswh4ZQ7O9c0UGOr62nLMjsSmyhmJTzQZk+eUjSE3TnInD+iGIKYPQWWKdY0n1lw6qrcOQk4T2wHvc7sBbxb2ufQzKipxJW3eY41NmY/LEs1607FDJ0QB7eugOgVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903571; c=relaxed/simple;
	bh=E5/KruvHPI1Cok+AHY6f5TV7h5T2HsKnWa1b44AaN9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rlW4bDYOPQN+f5RXOUAVc0rupwRi41TpctQU168eSz1MPfnhKoz/9tOrhoFKKGOXhbidEfIIBD5wDQOe2lpRw9kuqRfblYVE0UybHnM0H+8R9gmSYZaBToaFB9YuryArHsEgiphAs2+7aT3YUpqKPK02gK+p1thEq6d9UaV8MMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nKZRZ7Sz; arc=pass smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-40423dbe98bso1770254fac.2
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 07:06:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777903569; cv=none;
        d=google.com; s=arc-20240605;
        b=W8D8nygCUrVfSv6jwzssJrE8rLxSaXRw3xcyLmrgi1s2cBUXiWe5oAWnWeBRPWgQCc
         bEeDBos0iNsy4Gkv7YrqR707GWdRcoemFW3x4FQWqq4xNZwLJL0sDQty8XdLfnnbPhtZ
         fNRLPdxvQTT9CQzjBqAizbNBMSptq4OqZukyrBCDT0FSH2g8W9dlm2ZyNXeNXDyOC4VD
         GgZ51VT8FbvxB5uTee9Jm/wpe72n3a1Klm7RX7GKbUKEWy/lDLnLWJ12et9wjLz6DdiR
         kMNg6i6sSWhQpUyVfSjJOemBk9zyqaMeFmTI5u+h5692iG8qw1TTxZ26p5A0JsJO3eXi
         5jFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gfvrUqZPl7IK8aEaTm2E0KgpL5vRE9CMQj+nHgwI1uQ=;
        fh=f3BCIfWeBUtHkA/byKE1SjNYjMnq174aiufGEWY2RGU=;
        b=Md7lyJPhK4QMHFrXqvvxKSgj1mVjfXN+G6h1MLs54UDs86tWajzHk71O3qMuoph+HI
         dcPv5PVqCAuIyBNZxTB0SANt8mNBdapfPxC0fuOpTtsWCaqPL7vEp2YVFZMgtcXwISo+
         hBX7jchqwfexKuC6bjptFKMLth+CW63R3u1HW4dp/FIlMi9XGZalAMtQDML+vTHiqhh3
         TealON7Zv46UYizsLBUD1KdKOYgRxRn0b39AWn1rjd55+tzMxxAvx6I2k75BnYEJfRkv
         LYWw+OAcKrRromqBh99N/fl7WmOH5Lcc12DjDAJSP8d9hvN+qtMatm2XYbiHTd/gVcTu
         eyLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777903569; x=1778508369; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gfvrUqZPl7IK8aEaTm2E0KgpL5vRE9CMQj+nHgwI1uQ=;
        b=nKZRZ7Sz9D+qzHZuQf3baJELwJ+VJ4BXvz2i3iu2keb5BD/ZFu1pz88P0e+Od5J4aj
         HDCHdqykxHbDFtlugfDvFH+ySsqlAYQZAR/vz2Mg5H8z/WLiPa4lqqkYP9VGUyqf+JY4
         NmD0xie/Vfai5p0YKBtScrXJR/LYS0XJRyPkMH6PQ6OvS/nNKIV4FD42vmsqUcf8DzHO
         xzF61Jy+qYmlPMWhRGxmUUyc8wGsxqsIjzN2sXgJl3Au+PtLwV5Di+CBUsvkZMXQs0/y
         sGIjzDX0eDL77hoO0sWN626VF1MS+XKF8qkmhaQeg8NqnBKKRMvdAJOQWle+6indzxGX
         a8Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777903569; x=1778508369;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gfvrUqZPl7IK8aEaTm2E0KgpL5vRE9CMQj+nHgwI1uQ=;
        b=P8KrnSvNThPi373pSIlOAmMdcPAOl0TjoqUYkssg4xDLvLnc6djPFTF8uOz7upEbJO
         BIp5P/Kf4DXJ5uApA5naQOp0b8KeW9ww+/JHlZIrZh4YbInWvih3J4H+v3viACMvUuzr
         6fREIxPlV0cIBa3/HQqhq0rqnHwRODRXi9KqhmgCc1rl0OSGiGt6EKO1zL4A/cOhwPR9
         CRU855QYZ9ROiGIIFy7OZW7XThgTi1TWS8umLgDAF0vVZ1/EjGt0UHT5VQJR/Oc3aeHN
         mUE+LIgRHKm81mha7TG2l8POr0vhshHJ4d124n8Ti7blfHYkWysMviMW5MATbHQjA7E+
         MCTA==
X-Forwarded-Encrypted: i=1; AFNElJ9iG8Ko65yfLS+6sqLVqwPaKwFqP9OxK7XhkvdOE1oi797osa68t+JpsjvWd04EeOjC55Ny0Bg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCjsPDEutT8zG7za0HX9aKZD1Ud5P/n6IrYhY5rJUYY27LgYle
	t8PqLKBw+wF+BJ4YVrcjg5Wq4NrFwXNXVGyCjz25s7DqneRt1Nr/XlnO+c9HbjZ/J6Exjn/RrzN
	1XTmK13sIXCf8XmCrud035lFcMMjsfuM=
X-Gm-Gg: AeBDiesdxgonLHEAqrMjH6XTWmE4Wcuj7tTAfdaTr6Qj7sGXZNi/WutQ3Q2TN4T3Lcn
	evdmbnsenrwet92qZIQGoZ0nwvbz/vUTEeFbqjiKwCtGC4WXjDpYo3pbg4LUNjMRBC1M4TLrm0J
	3NZFU0g+AQDQVtkE/0n/Letz5xsaLraulBcF6sQrVsIBztl5augr/0lmbAzmEG+lYqI5FuhpOt+
	fSo2W9E1NwF5xSckT96uPmEpCS12kaKeRNe6EvEBheICBSEqtljcBNsZiPY6gpGoix9aVGooatS
	kk4G+YSaNHKWyTOTJ1EmTB3kwsDmSja61hfGteQeTmKUsI/1
X-Received: by 2002:a05:6870:16f1:b0:417:435c:ba0a with SMTP id
 586e51a60fabf-43476271a2cmr4601230fac.33.1777903565307; Mon, 04 May 2026
 07:06:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504062257.77460-1-devnexen@gmail.com> <2e4cc698-70da-4305-ad0c-b5258f029daf@lunn.ch>
In-Reply-To: <2e4cc698-70da-4305-ad0c-b5258f029daf@lunn.ch>
From: David CARLIER <devnexen@gmail.com>
Date: Mon, 4 May 2026 15:05:54 +0100
X-Gm-Features: AVHnY4LwHvTUwFkSxIZqjPr64tVI2rt-vWGl7Dm7NqH9VYh_y_KHOL51zrX-pI8
Message-ID: <CA+XhMqxjWOXVJXGUx5BE+U0S0SOOoSwaKu8eWigS=J5EfFejcQ@mail.gmail.com>
Subject: Re: [PATCH] ixgbe: E610: do not fill EEE lp_advertised from local PHY caps
To: Andrew Lunn <andrew@lunn.ch>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>, 
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Jacob Keller <jacob.e.keller@intel.com>, 
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: CC99E4BF361
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283860-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]

Hi Andrew,

  No E610 here, found it by reading the code - the X550 path
  (ixgbe_get_eee_fw) uses a separate FW_PHY_ACT_UD_2 activity and
  ixgbe_lp_map[] for partner data, the E610 path just feeds
  pcaps.eee_cap from REPORT_ACTIVE_CFG into lp_advertised. None of
  the IXGBE_ACI_REPORT_* modes return partner info so that field
  can't be right.

  The set path goes hw->mac.ops.setup_eee() ->
ixgbe_aci_set_phy_cfg(),
  so negotiation is in the firmware. eee_active / eee_enabled come
  from link.eee_status from the same FW, if those bits are right then
  negotiation works. Can't say more without hardware, Jedrzej or
  Aleksandr would know.

Cheers

