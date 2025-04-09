Return-Path: <netdev+bounces-180704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A18A82366
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 13:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D66451894F83
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 11:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4F225B664;
	Wed,  9 Apr 2025 11:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b="Vj/RkEDz"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9536B1BCA07
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 11:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744197645; cv=none; b=jKBuYBLnGvsTZy53lO5T9P7XTHmMuYzJdJ0D6kZg/MTtgpwZpwVj+nPmGwWBI4rFeAVsozYSOelzgEnznI561hW34b28gLpJEZPLdmExqZ5HJK+u66IqY9o16QofD0fk7kJVTdeeDA74WS3PkO4sYsMCeZzeQh+sysDfvFQcnow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744197645; c=relaxed/simple;
	bh=K1++ygWhlG7hqLQDlaVKkdv6BOQz1Ml+49o0yD+/G7A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VVlB6raBjQ7uXQhhhzXBiT6+lo7TkRnOlu9/0NQJPD/x99yxriNSL+lBrgr3g59js9SUxNxhif9qa6z5OesYURk/5TmALLGaau4TIuDrOJeAeTsUlwaUIssKVBoMKGV/uII+mUk6XlUIOoyaQ1KDzAX3krHSGX70c4o45Z33uzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn; spf=pass smtp.mailfrom=m.fudan.edu.cn; dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b=Vj/RkEDz; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.fudan.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=m.fudan.edu.cn;
	s=sorc2401; t=1744197613;
	bh=K1++ygWhlG7hqLQDlaVKkdv6BOQz1Ml+49o0yD+/G7A=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=Vj/RkEDzwnwcNWFJf8hueofr5jxgFy74a5hBnlXfMJRuQnGL7JyYb3ShfllL9Ghyi
	 AlHvyAnSI/N4yQUzlnFwrXlzvxXqpNfFj8+7n+sQ/GML0iLurt3jVFWqPWDhqBZR2E
	 c4c/j7ZDZkK9cpXSAzqQb3JUAPpgZ+23CU6C2tp0=
X-QQ-mid: bizesmtpip4t1744197605te21f33
X-QQ-Originating-IP: ecdAYd/Y5J668723nlpV/MJqIFhovhDgdL8+tE4PzCs=
Received: from t5820-2.fudan.edu.cn ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 09 Apr 2025 19:20:03 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13479172039318292541
EX-QQ-RecipientCnt: 3
From: ZiAo Li <23110240084@m.fudan.edu.cn>
To: stephen@networkplumber.org
Cc: 23110240084@m.fudan.edu.cn,
	netdev@vger.kernel.org
Subject: Re: Re: [PATCH iproute2] nstat: Fix NULL Pointer Dereference
Date: Wed,  9 Apr 2025 19:20:03 +0800
Message-Id: <20250409112003.1211812-1-23110240084@m.fudan.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250405083434.1c5b329e@hermes.local>
References: <20250405083434.1c5b329e@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:m.fudan.edu.cn:qybglogicsvrgz:qybglogicsvrgz7a-0
X-QQ-XMAILINFO: MCiK9DnWZEXspylyUeJVqwvO3sv3rxC7q6LGFVJSmilDMu9cktL9axTC
	GRIU72hHtV62JQOCdfWdIE4w2cbmy+f2VkSfzPIUUCM12hyj2kHhxlAqKoy/emlVNKO5rdu
	qGbipwKY2IOFnU8s3qwgOyPr+xSnd4YfypYoWmzDjL5EIHBySY1A7F8b2sM6CPlt99AX0m5
	S8HPTr3CwVQGXMSfLlR+UZxXBGCljbZe/+/0sr4bisUKl2EtxQo6fMvZswf6fD8vAxFRvig
	/1Cl3hiiSAbNz+bCWWazopEmamhLQMn/j3ZbyJzasgCnJuo9dJy4HCDNP+3zASBVwsmx+2K
	LgvlFbdoAx77RONsrxApVbAO0Y4o9Kvf0Bgb9GGkmu9dYzTalVeWUsVbNxKBFm9+SClxHT1
	JuZcn1FZ2iXJGqbwmkd28rPdj2id2OOrfUsQWC2WNNpmEn+PF+TecLWTQZPe1hKA/WWe5Q+
	pB8j1FTiw1dynVT+RbAKlltUUQ3f2jPp5s/z/P0I9whlj73d6jzztFP0Y/5uAviU9Kz5QxS
	ao/8SWjEb8dYbtkWi9+kcPc8h9yMHxDEgY5W9Gjzkd1QDwznWT4Gd7bB7N3ak9SsPlz3P/8
	GKoKOavxwGtCUwcG9EEPyexqdGc1nDDVEW5QcejIpp+aD5qqCRLqGdmUUFRqcMD3kYzyXlo
	ll5z0OqZ948G2dmJczpJ4SDr5dkqExuETuwXEJRdm6zx5N9rsijqKHJNoPlAMYNqTX3Hi1o
	o5VXV3K7GonT8H30QvWWTWOLcXV5ZhBoO80JHyNFPxaEnKfMd99l0laPVdlceBGP6Lob2GO
	JCGXKkimlIpnsmPXwneBiLtVRxSuZ8tRtZ63kizQ3Cy2J8EInzgNCoLez5yX8EcMwh8z2gu
	BEcKMhE8ZdmEiRjdxsYFHPAkMG+Ylvy3NAPutOkhXyipEe75OsybofhL3OAnX7nZosDKA0o
	8WuOe3inR+dDni7zfvUVkdUJLuO90QqHgSV4=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

Thank you for the review and sorry for the wrong format. I will look into the patching procedure carefully again and resubmit.

