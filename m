Return-Path: <netdev+bounces-124835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB36396B1E6
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 08:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54FB51F2758A
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 06:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339D112FF7B;
	Wed,  4 Sep 2024 06:36:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBD14AEE6;
	Wed,  4 Sep 2024 06:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725431811; cv=none; b=HsMU2qJJGB064F+mWY0s99DgPdRO05Gv8UM2XSWL04kE++7KmIWfCBjPKUXCOyQSnXScTYA/DTU//o0/1L6ZVkueoC7pOq0Wy1NiY2m2P7HjeyzuSScZPjgpLjkJhg/AVnoNVVs7KX9KzlccUzXAWYw86CCsgm7gmBQCUUIphSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725431811; c=relaxed/simple;
	bh=yTQAtWSN+H6CwtlGTvMxcSNJp+zg837c7qKrJvoxv2o=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=AaUHnNJn7vpVxBEKH20oYL7gUmKIP0aJk694aYXDXXJPfJrPZboBmgBFXMhGpFsSqQ7zB7QjrsoIBzCwpMgIkC/84IuHeirBbgejPT/Rx2ZQ+6WhytkZ6vX05MZoIMWoA7ODCWrAPs44paWCiQxU6OeeI/n4Zcf8NH1JE2lUaqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn; spf=pass smtp.mailfrom=m.fudan.edu.cn; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.fudan.edu.cn
X-QQ-GoodBg: 2
X-QQ-SSF: 0040000000000000
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-XMAILINFO: OQm4EXGVKR2Oi9rv6sl4DkRIfGeVZtz/Q1z144JBBmn4VyPdhStewz9M
	GIvx/vnIau9b/DBMNZxu+YlfFS9qxnQN0X2LrmJGb6V3DikgzoFLuKcqJ09Bjo+BEK7OpXx
	c9ej1lwVLycdDpBL1v1P4j3MrYd0Bz5JghktiE5tMrpN8/k/EpJ3PgP0tvqt5ziH+cLU8bj
	qUXlUGPk5veAy13BWEmjdKzzxCGJwMCSbOUQscIZdlE0CAcSrzHV+3oTp+IqmMQR3yz7vpi
	F8JdX/SVNOeRBsh0TgHFEDJnY55NtZLmfGwo7Kh1xkgEw7XLtl6LRORFR2Sp3PdY4axKCTN
	dJIv8wl/eYt4lSO/khTjrjiv5vqpcDHYHLA4CFPrVCdnzZ5octQnWgWNYd0Sg6G9idghpZx
	Z5noOKeTZyajJWQoh3Ik3aQNtq7n9yiKtnzhe0/zl+zOvNi48cgRJcyWV4mq8nz4V/Yzdco
	vHu4C3+cjIBILKhRN/67KbAMJFjaHOJOCDq03uvQCTHVQ88Ij5QUWsDnboWNiS7SCYU9Knf
	bKF9jlalslqUxpm6j2RiHpC5QAiDf9Qs8UII6x59ax1Fz+Ehp2QzS3bLmvOCnQBef//OPPE
	tfZ6cg+UyVko/HJWpYUtBlC7j3FlrZlVVh3o7vv9fVSVCUmGbCa6F/ZR7Kki1pOplZFYuPp
	mtybIowxREj7ujWah/NF5qnY5NNk/UBFjqWAaBCuOagTwj9d7YnBtWEKq98qD0HOq8/yoAb
	pNI4SkJOtfULD7ZoQyJF++2WsYirjpUoXSbKJP5oN8xsJtFo0OYLxCsWP9mwXwpHdnZDbjs
	rVKvh1mkOOqNxcsfS88B1eLth7YGUDlNDuMCiZO4SGPkIWKMWDqtpG/wXXk3w5jmy0O/Kz9
	K1k8xzRFo85lQMmTzAiVeC7UhLfy7hZxjMR9AnjVziXkpYRRc11q1iRATWH/gn3nXgc6SI0
	VQ10=
X-QQ-FEAT: 2Rmh/KmsIngruwTONLJY3WAWKAdbrRsw
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: iZHtMiyoMlMNLJlu7TpFOQdK10Qt68zyKSRrmqbkLWk=
X-QQ-STYLE: 
X-QQ-mid: t6sz3a-0t1725431490t1929350
From: "=?utf-8?B?V2VudGFpIERlbmc=?=" <wtdeng24@m.fudan.edu.cn>
To: "=?utf-8?B?QW5kcmV3IEx1bm4=?=" <andrew@lunn.ch>
Cc: "=?utf-8?B?bGludXg=?=" <linux@armlinux.org.uk>, "=?utf-8?B?ZGF2ZW0=?=" <davem@davemloft.net>, "=?utf-8?B?ZWR1bWF6ZXQ=?=" <edumazet@google.com>, "=?utf-8?B?a3ViYQ==?=" <kuba@kernel.org>, "=?utf-8?B?cGFiZW5p?=" <pabeni@redhat.com>, "=?utf-8?B?bGludXgtYXJtLWtlcm5lbA==?=" <linux-arm-kernel@lists.infradead.org>, "=?utf-8?B?bmV0ZGV2?=" <netdev@vger.kernel.org>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>, "=?utf-8?B?5p2c6Zuq55uI?=" <21210240012@m.fudan.edu.cn>
Subject: Re: [BUG] Possible Use-After-Free Vulnerability in ether3 Driver Due to Race Condition
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Wed, 4 Sep 2024 14:31:29 +0800
X-Priority: 3
Message-ID: <tencent_19E6DD6B2F73B82009E04699@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <tencent_48E7914150CBB05A03CD68C4@qq.com>
	<5d028583-07b5-4b4a-ba93-d9078084d502@lunn.ch>
In-Reply-To: <5d028583-07b5-4b4a-ba93-d9078084d502@lunn.ch>
X-QQ-ReplyHash: 3606267199
X-BIZMAIL-ID: 17366199070996424716
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Wed, 04 Sep 2024 14:31:30 +0800 (CST)
Feedback-ID: t:m.fudan.edu.cn:qybglogicsvrgz:qybglogicsvrgz7a-0

PiBQbGVhc2Ugc3VibWl0IGFuIGFjdHVhbCBwYXRjaCBmaXhpbmcgdGhlIGlzc3VlLiBXZSBj
YW4gdGhlbiBkZWNpZGUgaWYgaXQgaXMgdGhlIGNvcnJlY3QgZml4Lg0KDQpUaGFuayB5b3Ug
Zm9yIHRoZSBmZWVkYmFjay4gV2Ugd2lsbCBwcmVwYXJlIGFuZCBzdWJtaXQgYW4gYWN0dWFs
IHBhdGNoIHRoYXQgYWRkcmVzc2VzIHRoZSBpc3N1ZSBmb3IgeW91ciByZXZpZXcuDQoNCiAg
ICBXZW50YWk=


