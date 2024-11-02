Return-Path: <netdev+bounces-141250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1F19BA326
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 00:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13081B22594
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 23:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A4B1ABEB1;
	Sat,  2 Nov 2024 23:51:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail115-171.sinamail.sina.com.cn (mail115-171.sinamail.sina.com.cn [218.30.115.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17767166308
	for <netdev@vger.kernel.org>; Sat,  2 Nov 2024 23:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730591506; cv=none; b=Al5W3KbJME4wZxi9Tk8xj2IzL85HCFZsuQ26G4hZ1oflQ77L9dokOqrBK6o1jHqFQOD61DzSd1SU7O3QsywNv1tltHsDluav8hOtAz3cmnIYTVJT8xFxIVTg0ts9mEcbXYvVSPws/qNtcDODmWZVhQ305loz7VVhC7idrtqHqu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730591506; c=relaxed/simple;
	bh=V/ShPYdXFbBP+lfMirW8zb+RQf897FcNiuVPz0J9D2s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HZfNSLKeh1/xX/Ri6VjQO83BNjq01Z1NCKAyxL/mB6bcaMg+m3RML1+2rOVevorfWVZjbQYyWjvjOdcsJ2/0IRAb9Z1H4h+EysEUC60AmyDUl2mOM/gakeN9WZjDWx4G0JFZkfvjqgXv7/uZtCc6g5vZGb+2gdiGOAx69IVGjsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.49.217])
	by sina.com (10.185.250.24) with ESMTP
	id 6726BB0000004C17; Sat, 3 Nov 2024 07:51:33 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 22306910748379
X-SMAIL-UIID: 0E7C4CB5455C47378EC11F23ABE60A1E-20241103-075133-1
From: Hillf Danton <hdanton@sina.com>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 0/7] Suspend IRQs during application busy periods
Date: Sun,  3 Nov 2024 07:51:21 +0800
Message-Id: <20241102235121.3002-1-hdanton@sina.com>
In-Reply-To: <20241102005214.32443-1-jdamato@fastly.com>
References: 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat,  2 Nov 2024 00:51:56 +0000 Joe Damato <jdamato@fastly.com>
> 
> ~ Design rationale
> 
> The implementation of the IRQ suspension mechanism very nicely dovetails
> with the existing mechanism for IRQ deferral when preferred busy poll is
> enabled (introduced in commit 7fd3253a7de6 ("net: Introduce preferred
> busy-polling"), see that commit message for more details).

Pull Kselftest fixes from Shuah Khan: [1]

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=7fd3253a7de6

