Return-Path: <netdev+bounces-143683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE439C399F
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 09:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3295A28243C
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 08:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177C41662E9;
	Mon, 11 Nov 2024 08:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Wo++aYoa"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979BC15D5B6;
	Mon, 11 Nov 2024 08:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731313543; cv=none; b=W2sFoUpdl+SNFbrtTw6OZKAmaPngJuY5xEM9fX7Deflj5KKThI0/iupPmuhfaoylnrcEUby3GlWMTF1+PO8dw+n2TFYJa1SycDlTt//hMb6/VyrOigpFBzUQy7uDLowpnZLWXEpYHFvZx60lVT/KfwS7mp+ZN1fhxWD2zd4pjQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731313543; c=relaxed/simple;
	bh=iUNJr9JpCgUAFhS4PTw+aoLYhjfk39kNk25iEyfmiwk=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=np61xWKj9hgkD2KxtS7ehbJ/TA4ArmfTuVtCORsg/LHD0BRbSQgajMNr5WL/MFYhJzbgoRIi4FjVt1aHZuAo5nug3NA+xVEshJzHEEzDpQC932MMjbyp8sG7y9dQldKRKbkzCFOVWIrqcNUnIHPlxxvLGWisCgUe44G0oEiRhhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Wo++aYoa; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1731313515;
	bh=iUNJr9JpCgUAFhS4PTw+aoLYhjfk39kNk25iEyfmiwk=;
	h=From:To:Subject:Mime-Version:Date:Message-ID;
	b=Wo++aYoajBPiEgK7aWRHoodWUcMIpVCnl6B67GIddpTDFOfasMOeNGVADKnZiUp4S
	 Z16HDCJyfwUTfRFlFFU2MaoDeVUTYxZHaRVX8v7taqbuQd2KaYRGN1tuqlcNKaGnPh
	 1Q3VoFjN8ntYpd3PWi6yaUhfrE9VNWKXfoBzpek4=
X-QQ-GoodBg: 1
X-QQ-SSF: 00400000000000F0
X-QQ-FEAT: D4aqtcRDiqT6iyfUez+DXx4B7ybItHVbSxkDlA8/kMI=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: II5XqY6UgBSPuwSJdV4h1sWF9RwlXlN1tTxEkxkg9ss=
X-QQ-STYLE: 
X-QQ-mid: t5gz7a-2t1731313494t2020445
From: "=?utf-8?B?V2VudGFvIEd1YW4=?=" <guanwentao@uniontech.com>
To: "=?utf-8?B?546L5pix5Yqb?=" <wangyuli@uniontech.com>, "=?utf-8?B?YW5kcmV3?=" <andrew@lunn.ch>, "=?utf-8?B?aGthbGx3ZWl0MQ==?=" <hkallweit1@gmail.com>, "=?utf-8?B?bGludXg=?=" <linux@armlinux.org.uk>, "=?utf-8?B?ZGF2ZW0=?=" <davem@davemloft.net>, "=?utf-8?B?ZWR1bWF6ZXQ=?=" <edumazet@google.com>, "=?utf-8?B?a3ViYQ==?=" <kuba@kernel.org>, "=?utf-8?B?cGFiZW5p?=" <pabeni@redhat.com>
Cc: "=?utf-8?B?bmV0ZGV2?=" <netdev@vger.kernel.org>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>, "=?utf-8?B?5Y2g5L+K?=" <zhanjun@uniontech.com>, "=?utf-8?B?Zi5mYWluZWxsaQ==?=" <f.fainelli@gmail.com>, "=?utf-8?B?c2ViYXN0aWFuLmhlc3NlbGJhcnRo?=" <sebastian.hesselbarth@gmail.com>, "=?utf-8?B?bXVndW50aGFudm5t?=" <mugunthanvnm@ti.com>, "=?utf-8?B?Z2VlcnQrcmVuZXNhcw==?=" <geert+renesas@glider.be>, "=?utf-8?B?546L5pix5Yqb?=" <wangyuli@uniontech.com>
Subject: Re:[PATCH] net: phy: fix may not suspend when phy has WoL
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Mon, 11 Nov 2024 16:24:53 +0800
X-Priority: 3
Message-ID: <tencent_6056758936AF2CEE58AEBC36@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <ACDD37BE39A4EE18+20241111080627.1076283-1-wangyuli@uniontech.com>
In-Reply-To: <ACDD37BE39A4EE18+20241111080627.1076283-1-wangyuli@uniontech.com>
X-QQ-ReplyHash: 336625114
X-BIZMAIL-ID: 229188807990292030
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Mon, 11 Nov 2024 16:24:55 +0800 (CST)
Feedback-ID: t:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: ODcDgdcDagQKFEj6VVv/pQAUyQj5A1ryfXxtD0UBQTQeFSqLDEnvWrQg
	yMjQC3pOxzt1/f9Jvz49ktMVh4P5pLhTEQ74Uu8TD9L9ioiVgRhslwvo6xaw0Nb2v0p+dMY
	AE/f8d4ZlBRRbVm178G4iwPSWfSwTm/CdUoFH8L5N5Fy7SQ43SP+frZu6KnzoiyWK3sYTIa
	3qrIguhsuMB8DZfaAx0TNpUa9y43i0jPKNbDlGG0rtMpgXXf8G2T2ZagaXjPkgYMMoNYm+O
	1SBmrQpKyovPQKxUMxQLMJuaznpn20R9+INFk+XR2eJzPY2cechaRtwhuF1g1Rmh/ClN5Yi
	D0HTXiI+vkUnvHLkfIN4GvNHX21m6/c91ljHAB5eFSWm5uL/yxiYvYYnJ8/E6ulK5DWg2d1
	a+aHY/0qOh93mbpoWSdDtgNLoKGgxuP18j40OguW2JRKDzUkk5UMfDoyyYzl611JhAUJoK7
	aSHmZyJ4IItO0/SW1DZSg5F2O0V6O7elA3pybBQSyy4wm07/iAaFkXx/iOiDAIJl12j7l2s
	d0J3fkTlyT2AQmR7C8/6Rr24rVFW9z29sz8s/+HFlO04BZiLOtxUuz6nl1mMIEm8y//itl0
	cw0fKTf5JPDVJ67qlhxZ3WE8TdacozFTMrnPzI4qWo2xMfz8cUxQCoKKA7mNa//0sn2SffK
	Xdukm+HMtEC0/Q301vj5hc/X36AdzrMsiNfQqqO+ZW0xFyy15ImQVUOLslohqrcAT53FOaR
	Hvl3b8Ifma/4jnU4d4zOtStSkmVErhte/qPb7ucmr1otXimJq2icb2wCGjusrzdhMx4j5ip
	eQu+EbTxhBQ5nOmQCntY/orCvs/Ti7RVI+rXecno/IyMqQIBjq9XWFltLNT4/S14wR76bV6
	A1dVIswxnfuMiF92pl4SEjb6A4rBNvTztxPjLNdWaD1hHdD9qWiSoA0TxXEqAjO34p9UGHY
	lkg/O6yqbe68L/kbkKFXuHDuy+xw4y3pAYhjr4T+ogtph6q8OBgZVoLlA
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

TkFL


