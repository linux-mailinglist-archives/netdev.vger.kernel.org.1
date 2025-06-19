Return-Path: <netdev+bounces-199462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF9CAE0637
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 14:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4867E3BDD40
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 12:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1518623E347;
	Thu, 19 Jun 2025 12:50:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from ssh247.corpemail.net (ssh247.corpemail.net [210.51.61.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B557C229B29;
	Thu, 19 Jun 2025 12:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750337426; cv=none; b=HTsIOZqRmE3q651m0mNPgjEIPYKcbSnu0Y2JwU+91uIUVN7jbia5L8pvN6yeRk/YkdWdRmwKxCvHzsvw6YmMCRuJwKvblW5cTngjwWFDwO2OVIBYZMgWJPYbzrQVh0A/C0wdBtOKsEMbiz46jrHmUtDM+QaYnfn4Jv76AA//kRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750337426; c=relaxed/simple;
	bh=/jKrwIaeD9pBZ5wrOB4d4H5WfiAyrWjXfYlDh5cgNyo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b8iyA66FOlmoBtY7fZXsMgZoumQKV69Da5qK396C7qdCA5RYccPGy6UHaMDpSGV5OMR1qL/Za/5bo6fwIqNYcoiLFUybKuD9ItePf1N52TvRC3tR/BQJNBLTzXVHdaOM+RjeULca97P/iNJCGJXi/+KdVYbmcu0V025Vu81+dds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from Jtjnmail201618.home.langchao.com
        by ssh247.corpemail.net ((D)) with ASMTP (SSL) id 202506192050167261;
        Thu, 19 Jun 2025 20:50:16 +0800
Received: from localhost.localdomain.com (10.94.7.47) by
 Jtjnmail201618.home.langchao.com (10.100.2.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.57; Thu, 19 Jun 2025 20:50:15 +0800
From: chuguangqing <chuguangqing@inspur.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<intel-wired-lan@lists.osuosl.org>
Subject: Re: Re: [PATCH 1/1] check the ioremap return value first (supplementary CC)
Date: Thu, 19 Jun 2025 20:48:40 +0800
Message-ID: <20250619124921.44677-1-chuguangqing@inspur.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <9e82a899-7536-49a6-a4c5-c54fa96d8f50@redhat.com>
References: <9e82a899-7536-49a6-a4c5-c54fa96d8f50@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Jtjnmail201617.home.langchao.com (10.100.2.17) To
 Jtjnmail201618.home.langchao.com (10.100.2.18)
tUid: 20256192050162936b2d1b4759160269d87d83bf9d30a
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

 tks to pabeni. 
 cc the relevant ML in the email.


