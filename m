Return-Path: <netdev+bounces-91210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7A48B1B4D
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 08:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2E1E1C20FA3
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 06:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F015A4D5;
	Thu, 25 Apr 2024 06:56:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00B01DFE4
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 06:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714028162; cv=none; b=N8nyBRhYmSqgqXqugELp3J5FLpnS9APZ5qdkdokRPBlneDXRDldtKnR6M7ePu9ejOb8KkU5YCSe246mjkfR1gKxYoM/5TMnuJrm7YJg+CztUpDdYxxEXfZ1hmZ9jzQJJOFk5cngvCF+jKZZrIy0MJsryhLGSENFjxGiQ+xDbupU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714028162; c=relaxed/simple;
	bh=O7gu1iG6btZE7MOBadHnNgNlv2vQSSeIveE3k1Yt8+s=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZfCh+ld18kC10rFFvKSdxJ1mhZxp3k7vAkDyzht4+pni4Qj2K9lssGc6FMLZYEpwuhST5q0mb2QPkoQau2SUlq1gt/vcLlvF459Qet+lfnrAf1Oq6eiP3EjlNpfCecH7xGOrTT/7cQkN7jLR2+AEwWF7f5kkFKLBF0fLvQjNjyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas49t1714028005t763t52301
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [115.195.151.153])
X-QQ-SSF:00400000000000F0FUF000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 7907587342363166786
To: "'Simon Horman'" <horms@kernel.org>
Cc: <davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<rmk+kernel@armlinux.org.uk>,
	<andrew@lunn.ch>,
	<netdev@vger.kernel.org>,
	<mengyuanlou@net-swift.com>,
	<duanqiangwen@net-swift.com>
References: <20240416062952.14196-1-jiawenwu@trustnetic.com> <20240416062952.14196-5-jiawenwu@trustnetic.com> <20240418185851.GQ3975545@kernel.org>
In-Reply-To: <20240418185851.GQ3975545@kernel.org>
Subject: RE: [PATCH net 4/5] net: wangxun: change NETIF_F_HW_VLAN_STAG_* to fixed features
Date: Thu, 25 Apr 2024 14:53:24 +0800
Message-ID: <057001da96dd$44b592a0$ce20b7e0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQMFotcmuiiFX27azvFEImaFqcAi9wCPUoUSAgYg8sevDcc6sA==
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1

On Fri, April 19, 2024 2:59 AM, Simon Horman wrote:
> On Tue, Apr 16, 2024 at 02:29:51PM +0800, Jiawen Wu wrote:
> > Because the hardware doesn't support the configuration of VLAN STAG,
> > remove NETIF_F_HW_VLAN_STAG_* in netdev->features, and set their state
> > to be consistent with NETIF_F_HW_VLAN_CTAG_*.
> >
> > Fixes: 6670f1ece2c8 ("net: txgbe: Add netdev features support")
> > Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> 
> Hi Jiawen Wu,
> 
> I am having trouble reconciling "hardware doesn't support the configuration
> of VLAN STAG" with both "set their state to be consistent with
> NETIF_F_HW_VLAN_CTAG_*" and the code changes.
> 
> Is the problem here not that VLAN STAGs aren't supported by
> the HW, but rather that the HW requires that corresponding
> CTAG and STAG configuration always matches?
> 
> I.e, the HW requires:
> 
>   f & NETIF_F_HW_VLAN_CTAG_FILTER == f & NETIF_F_HW_VLAN_STAG_FILTER
>   f & NETIF_F_HW_VLAN_CTAG_RX     == f & NETIF_F_HW_VLAN_STAG_RX
>   f & NETIF_F_HW_VLAN_CTAG_TX     == f & NETIF_F_HW_VLAN_STAG_TX
> 
> If so, I wonder if only the wx_fix_features() portion of
> this patch is required.

You are right. I need to set their state to be consistent in wx_fix_features(),
this patch is missing the case when STAG changes.



