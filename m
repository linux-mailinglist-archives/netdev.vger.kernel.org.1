Return-Path: <netdev+bounces-186409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE62CA9EFCA
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 13:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2EF116C832
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 11:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286F6266EE0;
	Mon, 28 Apr 2025 11:55:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEC8265CD2;
	Mon, 28 Apr 2025 11:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745841355; cv=none; b=gK1aNURunedbhAzQvK5OSGx5l4gYNeLp/eHZ+LazcmiPH7/gK3A/KLlwcY0ETNgMuF+sXDxy97NsGhmyq7wK5li72oEHxgACE6Ogq0bF6GYPE9gbhh4ZcraDoVMWdj4+P4LuSY0WfcsYsuKHNY+DTWGjZwSoZbHztDwXuw/11/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745841355; c=relaxed/simple;
	bh=bs4sVu1SDPDV04Utncap5yMSBI6QPAR58r0OfdUFcg0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CXBivMs5vBhDngX7AT+9Y0ush7NVMxo1Rj8dFdKBiDTPue3LIY/yerfhgyfkLNHuHjFjhkIT1p9wtVnOEN20CtWtS/WbmWfnQug7d1VS+pS/VAG7DwVJ5a9v6QnofR2Bexp7vgSOfV8ql8d1duQuDTpGzfxUom/S/Tskk4Xi1Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinsec.com.cn; spf=none smtp.mailfrom=kylinsec.com.cn; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinsec.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kylinsec.com.cn
X-QQ-mid: zesmtpsz3t1745841187td2361a33
X-QQ-Originating-IP: ys7IB8NA/ghcXVMpoph0BeV5U9UDEae97i3K2hj40cY=
Received: from localhost.localdomain ( [175.9.43.233])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 28 Apr 2025 19:53:05 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18270107804818011286
EX-QQ-RecipientCnt: 9
From: Zhou Bowen <zhoubowen@kylinsec.com.cn>
To: horms@kernel.org
Cc: Shyam-sundar.S-k@amd.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	zhoubowen@kylinsec.com.cn
Subject: Re: [PATCH] amd-xgbe: Add device IDs for Hygon 10Gb ethernet controller
Date: Mon, 28 Apr 2025 19:50:44 +0800
Message-Id: <20250428115044.2472511-1-zhoubowen@kylinsec.com.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20250416185218.GY395307@horms.kernel.org>
References: <20250415132006.11268-1-zhoubowen@kylinsec.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:kylinsec.com.cn:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NiYVgwQNWo+48meKEqbT6gaYaTShYr6EMXuDvC7wDClzUxwDeUyB4dAs
	fWnjh8tpejbHs6rHe0JPgLJVt4RpQY1/ofzmTtVO0GEaKp9fUwDlgjLX6srp+tpnewo1nbs
	e6LTmGdAR0fR5ujIa0n9HEQYDpTan6qsuViWcmUxWTUN4GgVlJXG16b/BMmxgIY6fOR4c2e
	uXUIfmdtz9RQvlPOkBFzv9bKMXEwWcrBJ+Z5UBAbVwO6cKGpJNaAxxZ0/5iIx4Zd2aEMVw4
	ON1G8iEPzamYYoYREzo0GONT7Nt8TMBHBKU5Zi/wCGr3qec8mz+D/y9WbeP5Z/mUHtX7tuQ
	MDSp24Tt+zaf+hS/x9FXC+lxeHxzJBh4YZsDjxPOwqunwADe2UOKHAYxKb5iqW2lmUiBBiQ
	6SHrYcm79VBsOGNCTxqnoji8TWrgkTxqfbtB69K3YoPe6rNXLqGeDIZ4ijjUJRppgOHw6vI
	NzfwDs9gjUhDoga+Zpyd+8fC2zZtc8JbeKNRaIkAmr+fY/JSyZLN5LNQ+8ph9/ADmYMmnQF
	r6Vbu+xw5r7xN1O0rPGlHQWZXHL2J9nah6MuQXZ1IEACV7sXnWFIPHopPqgKfoIHxKMxr2k
	1QFqnekv6uBno8rBk9xQpw5IEetDJmu2NwGfbj7eCXjkJ8krnmNGgQ6EwD8PNyzCkWEyVt5
	2SU/q5Ke9K+Mt3QQmtl5y1ya3mFJXCw+k00C26RO0va+MsFrcD1Wa/kTMWrkPs7YpPYDrXO
	iYLerDB6KZkyVRA0HZfoETY1I8LBCYdL66dCTGTRfn4vWxPAagwauU7ZN81W+mOHzWXAABn
	X7i8xzkQSAUj13DNwRWlNiZPr/c9PPm6R+qxynlBH8hj2/U8XFZHAV8T1FcuhB2tdTRr51n
	mo8Inffsbgf3TJecx9u5FxFCN4PCK6Gh41ebvdiEU6+qQwnkSWO4JlRD85perTZMBjkzXpk
	pHs4cUTgNCrwV5XVeK7/ipZHKMI8j7OyZr5ZcH0vNGJ2U18K90mkCVJZhEOaunF9dsa/g+T
	QnvLAC5JWg0JKy8lqWEduAl4N5Hp9P40dx7mLVKz/PStkPIDThhSjFS/uDXLbBlKPZFzTur
	jzKDS3f6pp/HDdwXJWOpVhvx30hrOSJtfIdvvkNk828
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

Hi Simon,

Thank you for reviewing the patch!

>On Tue, Apr 15, 2025 at 09:20:06PM +0800, zhoubowen wrote:
>> Add device IDs for Hygon 10Gb Ethernet controller.
>
>Am I correct in assuming that with this change in place these devices
>function correctly with this driver without further modification to it?
>

Yes, this patch has been validated on the Hygon C86-3G platform with the on-board 10GbE NIC.
It works properly (link up/down, data transfer, etc.) without any additional modifications.

>> Signed-off-by: zhoubowen <zhoubowen@kylinsec.com.cn>
>
>Please consider adding a space between your first and family name,
>and capitalising each name in the Signed-off-by and From of
>the patch. e.g. Zhou Bowen

Thanks for your comments, I will fix it,and the corresponding patch will be reissued next time.

--
Best regards,
Zhou Bowen

---

