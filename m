Return-Path: <netdev+bounces-237809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA24C50784
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 05:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E577434D86A
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 04:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF872D5920;
	Wed, 12 Nov 2025 04:00:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.lsv.jp (ns1.lsv.jp [133.18.31.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD35C2D3217
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 04:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=133.18.31.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762920005; cv=none; b=OSn4Sxo45dqIwZ4QtVWnOquCmtr4OSqJzBbQxx27/LGK5DkiFImYuEtqhC6zjqxMcSr0gpff08M2T33c7MPHPmnCQSEg105K1deCO2yCYIEf/wSrUKZLLnwNbDfR4sprQbsGAVGUMf5an0Twz6org1OYoDnu/7fXqW5vM8XlWdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762920005; c=relaxed/simple;
	bh=1lW6gQPeGdUQiYLyOUf3tUhKAz4GhVShWonsE7+Kf3Q=;
	h=To:Subject:From:Content-Type:Message-Id:Date; b=TA0scXSIN9ZZ1TJNVg3QDru6GCxeAWEZ9c4VJmrPV0bRHJulrMNq2v1Y2nbsk2xnM/MT+EQLV89Yoom70d+qFs5ufkzrMpMmsEfSwNUVrRpkUrqh1eIUoAiYkM7Ri7g7Tsm0H50DISXNuDDclCaW2wzq6L6aYPMtbaDCtvg6L8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=f-elead.biz; spf=pass smtp.mailfrom=cv3.lsv.jp; arc=none smtp.client-ip=133.18.31.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=f-elead.biz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cv3.lsv.jp
Received: from cv3.lsv.jp (cv3.lsv.jp [113.36.242.232])
	by smtp.lsv.jp (Postfix) with ESMTP id 0A5BB11C115D
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 12:51:25 +0900 (JST)
Received: by cv3.lsv.jp (Postfix, from userid 1717)
	id EEC16403ACD9A; Wed, 12 Nov 2025 12:51:24 +0900 (JST)
To: netdev@vger.kernel.org
Subject: =?iso-2022-jp?B?GyRCR1s/LkRkO18kcjx1JDFJVSQxJF4kNyQ/GyhC?=
From: info@f-elead.biz
Reply-To: info@f-elead.biz
Content-Type: text/plain;charset=iso-2022-jp
X-Mailer: PHP/7.4.27
Message-Id: <20251112035124.EEC16403ACD9A@cv3.lsv.jp>
Date: Wed, 12 Nov 2025 12:51:24 +0900 (JST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

メール配信手続きを受け付けました。

配信停止の手続きまで１〜２営業日程度かかりますこと、
何卒ご了承いただきますようお願い申し上げます。
 

イーリード
＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

【 Email 】 netdev@vger.kernel.org

＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

送信日時：2025/11/12 (Wed) 12:51:24


