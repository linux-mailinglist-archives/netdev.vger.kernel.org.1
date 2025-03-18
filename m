Return-Path: <netdev+bounces-175652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B11C6A66FFA
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 10:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EF024231FB
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 09:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CB5207A34;
	Tue, 18 Mar 2025 09:37:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983C21F7076
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 09:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742290629; cv=none; b=fhzx+YAMiEC2mWiDUhqGzEbMWgx6os98N/E9HebQgJ1ah3jvF9OvrCjRFmX71L382WgZt5vb6+/mqgHpQRgRbqLDKwUlRm6805nxcCUFalOdp7g45sxyGHtdNkU2kr3TTQLgx7vxG9HuOawjzAbf8aNyDF2axL10/GNkLRq2XoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742290629; c=relaxed/simple;
	bh=Qtu0CfwKAeZe4zGYxFPTzRyM57dh+wp3XLeqU0dGaHA=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=IY26frvFQxBNZ/9/2DDb0EtfXPl+4dD4AeyLjszXrlQcbci6MdFq0/ae2nqogW3DFx6KqOGDaBDDSSrUACIgCdAhuSokPdaAlEVX4rYXZX4UJ33pPwcdPtVRl0Ka0rkumo9ELRttUPK/l7WJ2z7w0YClQw24quDcvWtaJHrw9rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas3t1742290595t765t09490
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [60.186.240.18])
X-QQ-SSF:0001000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 2908365651493764068
To: "'Mengyuan Lou'" <mengyuanlou@net-swift.com>,
	<netdev@vger.kernel.org>
Cc: <kuba@kernel.org>,
	<duanqiangwen@net-swift.com>
References: <20250309154252.79234-1-mengyuanlou@net-swift.com> <20250309154252.79234-3-mengyuanlou@net-swift.com>
In-Reply-To: <20250309154252.79234-3-mengyuanlou@net-swift.com>
Subject: RE: [PATCH net-next v8 2/6] net: libwx: Add sriov api for wangxun nics
Date: Tue, 18 Mar 2025 17:36:34 +0800
Message-ID: <01d201db97e9$3d50a0f0$b7f1e2d0$@trustnetic.com>
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
Thread-Index: AQIdnCnDiPhOE0ov2X5Z+2K6KJbCAAI+4deUsuDZxIA=
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NzSDQCFWCzVTF+Sps1TZsQAg3pwU5o31D5HxMI34KZqO+MfNpZ8xPeEA
	8v0R0Nn9lW3JfMj0cpwo/f5sqBrbHKB3UyBXRPNknh2RZHHHbg3iIX5m3tYamZVlkRJ2ehV
	iKnlEKV7HN0VkeFHris8LSi1LdAvtAVhTALbW5IXKAsvegkE4wjPIIJbkaQ5pbk3sEHXOYf
	SLehrbQsm+OtyeU424OwNLaH0sB+Yl3/w5EyCP8J9I2/+sR8/9t7Q/uedoLIXZyt9GC3veC
	guDSlf2tPsUbj8ecF118kLTnPfsUCnB0bM8CEvBY/Fsbsq2lnehvE4qMA6hzAMTNySS5bRq
	N12zRtQBMbSJjJdbXkjvjh3YtoqYEqTZk2cuNFb3yAKLBdcNpjdbRwFdUqjI1/6eixEzZKN
	glyv8/QKM290sRVywI/vcU4NsoPuSbnsvv5kNmtb8dfBHu0CXXZjPnWSGLDbBMs2K+ECy0P
	mgPLoXUqCJmEEuRRVjiuxq49K+ojrgARZZBp5JjkzcACvT8gFYITH33TZYRyYogR+Ww4SrQ
	J8wGpfkSSSepG7f8p6SanBbRqZ/CcrNf6qqHSMTAuwq9sQDY2XchK02LD7J6q4M/JYPxFAm
	j0wbyAPQDFhultNboYSer1BknM6WlA5PKZ+wslrmQNczw26M8flhSTvv/EAcxTux0akHvTz
	SLHrQJe1jxvoATvKCzDJ+CJNmfdpzIGuwe5glUSj/0zASbPLNcCN6Cz28qvtdqSy6Ix+K0Y
	z+iNrHDkiWgziTVMoXoGiFpCh1u/RyGI9rblwJG6rWspxZ5PqLcNd/Wqx1d7ztjJ05Nr9Lf
	IZDMq0M6sKfKF+mZwWFy9OU//mW6HH+cDtBZ3Ab2WLo7/PTAMm26jTmi6G/iqgQY1ac7r3E
	moeQYWqk9NUX/Bgu9JX4zPec7oZKHmQ+k/hmivGDkYePy6pUNOmj9QO/+wi1pgsRp6u7pN6
	/2mYStin41fDK2N/FDMTgC0zptZkuZPI/0b2qMDlyfJovTUybYuOk+MmmfDBgeNLTSdw=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

> +static int __wx_enable_sriov(struct wx *wx, u8 num_vfs)
> +{
> +	int i, ret = 0;
> +	u32 value = 0;
> +
> +	set_bit(WX_FLAG_SRIOV_ENABLED, wx->flags);
> +	wx_err(wx, "SR-IOV enabled with %d VFs\n", num_vfs);
> +
> +	/* Enable VMDq flag so device will be set in VM mode */
> +	set_bit(WX_FLAG_VMDQ_ENABLED, wx->flags);
> +	if (!wx->ring_feature[RING_F_VMDQ].limit)
> +		wx->ring_feature[RING_F_VMDQ].limit = 1;
> +	wx->ring_feature[RING_F_VMDQ].offset = num_vfs;
> +
> +	wx->vfinfo = kcalloc(num_vfs, sizeof(struct vf_data_storage),
> +			     GFP_KERNEL);
> +	if (!wx->vfinfo)
> +		return -ENOMEM;
> +
> +	ret = wx_alloc_vf_macvlans(wx, num_vfs);
> +	if (ret)
> +		return ret;
> +
> +	/* Initialize default switching mode VEB */
> +	wr32m(wx, WX_PSR_CTL, WX_PSR_CTL_SW_EN, WX_PSR_CTL_SW_EN);
> +
> +	for (i = 0; i < num_vfs; i++) {
> +		/* enable spoof checking for all VFs */
> +		wx->vfinfo[i].spoofchk_enabled = true;
> +		wx->vfinfo[i].link_enable = true;
> +		/* untrust all VFs */
> +		wx->vfinfo[i].trusted = false;
> +		/* set the default xcast mode */
> +		wx->vfinfo[i].xcast_mode = WXVF_XCAST_MODE_NONE;
> +	}
> +
> +	if (wx->mac.type == wx_mac_sp) {
> +		if (num_vfs < 32)
> +			value = WX_CFG_PORT_CTL_NUM_VT_32;
> +		else
> +			value = WX_CFG_PORT_CTL_NUM_VT_64;
> +	} else {
> +		value = WX_CFG_PORT_CTL_NUM_VT_8;
> +	}

For the intention of supporting AML devices,

switch (wx->mac.type) {
case wx_mac_sp:
case wx_mac_aml:
	...
case wx_mac_em:
	...
default:
	...
}

> +	wr32m(wx, WX_CFG_PORT_CTL,
> +	      WX_CFG_PORT_CTL_NUM_VT_MASK,
> +	      value);
> +
> +	return ret;
> +}
> +
 


