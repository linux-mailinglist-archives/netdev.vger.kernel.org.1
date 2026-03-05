Return-Path: <netdev+bounces-264398-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDfDOX6JqWki+gAAu9opvQ
	(envelope-from <netdev+bounces-264398-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 14:47:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3FE212BDF
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 14:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1F53530082B5
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 13:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E1139A045;
	Thu,  5 Mar 2026 13:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="goedJVLS"
X-Original-To: netdev@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021081.outbound.protection.outlook.com [40.107.74.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901801E5207;
	Thu,  5 Mar 2026 13:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772718460; cv=fail; b=Va0MEzAc6ercpHbXyNau6iYivCCNiZDColrElovhpH7CBkP0ee/6jqgkEqqZGGS9O3j3rCvT4qFMG9P768rxuBwkw0dSDRstnCgy1bo9J8JY3U4DSmyOgCbVFZcbsCE072aU5AfBuyHJ5g643IAtsFMv3Gv8CThdakOEP/skMhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772718460; c=relaxed/simple;
	bh=Z4Q2fdOXil7r7Rb82ezE33l46Aoz9gtXLOX1bUVw0Ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LRuiyF0ChzPP+y420cdV/NKoFnLbXf6Db0YBkU0PaHiK9KOemiGKNs0H5Yxvzk7gHp2cAROpyXK/6SaxeuBEx/XLEY+gfeNNJvy9+bUorH05ij+X+WZSBPYSc7SACYTye7BSGa6wk09o6Zvz+V5ZleBclA78tVnh6O9r8TF5X7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=goedJVLS; arc=fail smtp.client-ip=40.107.74.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BTiPvPLjLjP60/lFAX/ybI/348xZzi4R2AyCGPiFn5edmcbfriBwzk+3oAwturN1W2PIHiJ74qljx7ugnh54W74T8KbveicfILecfS++IrinRXcoHsMBeDzlVA5hrZfWB4Iv+fMex7Yo6LgRK5AAsrSZYLEzSeZsJ4vzYD7gXnll0nJNFiEzR6ZAT04AU0BQ+NTcl3DdIviKFWDUiw/yRLFXaXLzb01FOJtDNYwTQKMMe5sg6CEpRwc5FWOk+t8naV28L38p7YEO8y7GdMhMuBnnB1JA8t6XPB6zfUZu4ifPrJRMZZ4XRrtSGAL0fKMVTdsKh5UYnbMz/FKEFwe5fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DXW0PCmZuZrXr+povreCHbupJlry2hWT0mcpE56rBoY=;
 b=h2W03U0loB5WeDIigFwD8cVlDtf79uFHff4ragDfV3IK3hkDeTKe0wWbwwKUfihDb3hXvMmRKH5JCMftHBkoe+U6MjxO+V6U4dTAvrjQLd3w+yjSd/j0YehIhR8nt787HJWcHsWChBePCn1a1015fTfCEqV7BvXcAep/wqCMT5gNy7Tamx/hhwOTScwPf6vPM3DQavgt/GmaitXmE08UTPMH2Gs9QLAD+WI/amh+MsdT0GOmMbm6wRpChI50cvDVqTIYMKQCPw8dZooRsXvdEcvLNmT8Qist2pDy2jlZaAcbToiUpFiTi+0P3qVU76W0WqpD5NVce5CL0bZxp3XRhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DXW0PCmZuZrXr+povreCHbupJlry2hWT0mcpE56rBoY=;
 b=goedJVLS1jlG8f/0gawLAUNOO4rM4YJc9ab/CsvcalMDSR2vzIUn68Sn80pjlP6RccLNhjmp3iqRl32OXDczA8xXpf9EIfb4R8fQbdtH53rEZguBKLOpPZb2qpGW2sI9N5fAx0CFJPpQygCLs0hpFKuiJG7w2NJiuhUJdPYPHa8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYTP286MB3502.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:39b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 13:47:35 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9678.016; Thu, 5 Mar 2026
 13:47:35 +0000
Date: Thu, 5 Mar 2026 22:47:33 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, ntb@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] net: ntb_netdev: Support ethtool channels for
 multi-queue
Message-ID: <xkamblybtxvujqq537ixw4wury7kxhbcyanemuiuqlmpdpav6k@3aucrdzsktmg>
References: <20260228145538.3955864-1-den@valinux.co.jp>
 <20260228145538.3955864-5-den@valinux.co.jp>
 <20260304171930.5c3625eb@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304171930.5c3625eb@kernel.org>
X-ClientProxiedBy: TYCP286CA0265.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455::17) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYTP286MB3502:EE_
X-MS-Office365-Filtering-Correlation-Id: f46dd6ec-2777-437b-291f-08de7abdc1e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	89/27u5PlumJ4Hl8dmtjRfjyt80SlTcKW/oxwsbNg2a4kjKwrl6QcwNrAcNTxcXkHVkCg7efqd8MHK5Mbku4qOoEBy93FsrmpRUm87L6QrmFszgAEpY8xNO4/T/lLX2E6kJpnr6FgOU38RMjoxNpw3RYO28ayANqeRjhA2/l4VdnhSk3tnPcfwawyyHkRKS1atsxtASbFf/t66Xrvyy7U3rdAY0TK29Sjj8JmphvMNH+eYNMRBy9uZjLweDL6UwKvo1RuL8lLyPOedPqYIiYvK7Pp2Le8CTtpInxIW6do+w01xK/pP5kzYinQNa5ROTzG9ALl6k4M5uBN4W4bqxPvRza9ly8WEI6R7jo5wMNCTXY0xSrBlsWF87wIwFkI3hOuyZEIusXwrrvsWZTDTjQcsd+aLWbDQNDaGDz6ZRFCC2YCHPJn+svzrVYS8uTSXizVTjfYdKY00g7wdtTMwghZsYnUuM0tGDsy/vBLKhyLec4H4YfZlPk7Xm2KiYNVLN7S5G9OfQuz0y67Qp7NAs7K0pwotzxtNzLl0xhn/9/Z9SVXxqY6wWj4fXSYle3u/t9Aem5WSfUr2oFqm5Fc9ryzxq4ixrbbrfhSlTEQvQi129xn3MG1mKTx/x13KahMzVWMI2PtFWYTZ/I5yx3AdCxPeE0J+V3RZVntS8WDL2oNrUVoZp7ZiYl33yZD2BxtAv5haoGaacvEl5D3R+SDDhbV/tLtJPImnvYiwuF34QKwdw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?srpmegziEhoIYDMHMvZ9kS+J0q1usqkdPJq1zUSiFiixwUP0laB3j5udeL+c?=
 =?us-ascii?Q?b5qW9HEN6211B2BlfPEyHgpBmx2YH+bLAlTpIeysT+U3NzAxiepWXZu55sHN?=
 =?us-ascii?Q?QKDWumR3WWvoSG+A021CU+uKnzow0ZK8ZyUcl33GnJqNgln+tPYAMeum/l59?=
 =?us-ascii?Q?6m+5V5sZPuSGMQRKdwGFEefF3kGFk4RJU2wwBtWkNEX2wbL5LOKzRh7WoTGl?=
 =?us-ascii?Q?ixhl3MmSSlgxh4RLl+07H/TG4Wms51hA3zz0FtplAmp9Rf6CPvrdKfrgeeQz?=
 =?us-ascii?Q?+qM5LP8Os1Kwkz1Qg5z407T9Wq9xBhGgm6JfIA1w1hxyeaE9Jzy4CG7WLxyE?=
 =?us-ascii?Q?p4EZqwNHYnmJkRYup0JOKQSJ2XIzyE4uJZvllJF2o/y2obJ39EEjUClNTZ2T?=
 =?us-ascii?Q?7hk/jcnrvIfX94H1GeYDIvJy3wmkG0Fx0HsSVD53LMcDIp/OHz+fc6QGguE5?=
 =?us-ascii?Q?oOH61rI0c4GB1QRkB+8jP7we3rz+92zLJMO7Ld1wGQ72/tjJxsFGPe3xptL6?=
 =?us-ascii?Q?740eNM7HVdOmPMDKJOB/HUV1LJLkDkiURiliUhw/Ju39j1Avp16mv9mteTs1?=
 =?us-ascii?Q?Od3/gdUybooEOXl0+du77VzmStHDqXd0XehDttMdPvjrP3q51JLAVMi0OkIt?=
 =?us-ascii?Q?72zYpHFVNElo3P6RRXC1ji0r1Mrnc0wvd+T0xJlSCDCYsmDErJ99Yg66iYjT?=
 =?us-ascii?Q?mVwa+dNZopQ0mGNRj9QkrbXiEmHJCmeU7hVfEL5bwRutQuZekgaenEaNm+Rf?=
 =?us-ascii?Q?CZy5xwqr2i9uk5+evSvr2AjU2xD2ZJJIbk+zREOLPunEai8sZjfRg4nvzEJB?=
 =?us-ascii?Q?aYBRer0fBFbhII3/nyl2ESVO0j/FyDEI8ije+4Wg2ELn14tOhOibSf3omVAs?=
 =?us-ascii?Q?w2PCJYv0SSRUepOTIdweai5KW612f0iyyK5WCF5k/U9mS/hTP62ztkRKKFMx?=
 =?us-ascii?Q?YKNErzczDIoUz8YfFpFsp6P4bJ3RM6iYrGgRhBmwd1yBNK4T/6GunrXyZe93?=
 =?us-ascii?Q?u3jGkXAyJIDPj02zvuEPBq9J2FWACehqj4hQ+vu4qww6o5FlXH0oRdtm/p0z?=
 =?us-ascii?Q?LlF1Y/YgK2sKxVtVh4RYxoTkyz2uWL3dZCiGJgnJ3QNy5jAsx1OAMCRtjuG2?=
 =?us-ascii?Q?4JEBnP4BWfoVD/j0ex2PXRFUFXVEokbobK6cBcMb0Wjx18nyj+W9D2Tpl8Cp?=
 =?us-ascii?Q?zDvdG/7KzOwD0dNvYL2eZVmnN3Qt2e5TdsU3innbRVaIonSjhYpGZEBQO8hS?=
 =?us-ascii?Q?Kjqrz958dLhRZ01BK4RmH4aG0U7XrED/pLXvnsoO0DI0nUPL4wKHflbBdrul?=
 =?us-ascii?Q?x09+8ZcQSrLfHcDA3kt0vydAcDy20w3Vi4R09wVWIzoIuNLFMuRZz7TNsMa6?=
 =?us-ascii?Q?NFJijQAnASUOnRHdF97LrkQ6rpnc4ykTril2qipKIFkzVqd0kbPQDx8WE58p?=
 =?us-ascii?Q?zriZUouxZV3MTfAQdllGo0uiT5Ws5TU9LGtWYQ2zOXQX3hrWfE26fpLjwY6z?=
 =?us-ascii?Q?I72PqCqoG8Czao+9EQw+wvM1FI4XYhhWSwvpBGJUeRF4McsRAIiqc+HPHhZj?=
 =?us-ascii?Q?vmDNfP6o08PINhwj6LlB1b+EYxvQ21meMGgPtY1a9E4r4BqkKufba655aK/q?=
 =?us-ascii?Q?Z3LCtpUWE2hb64mOddbHH38lM772dJ6oyfITrAw8Ss0sdzfwoQ4JSG2Gm85T?=
 =?us-ascii?Q?s4R4Qv+3gtO3o8iLZnC4/ExriecF9EyZAoHvHkptl7gB3BmpQSZtpuT+CZir?=
 =?us-ascii?Q?/H29l6BRtS604SO4GiMNVyMcsHHmBtJ7XYPZveoiOnVF055IMj4F?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: f46dd6ec-2777-437b-291f-08de7abdc1e5
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 13:47:35.4467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RQqeOANNSihcuBufJ950GEtMYL2HVs4D5GstzheyiQEHSMI43TXZCBRsgOBzNgcpB8up0xiO46Ke7wl+kmUjNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYTP286MB3502
X-Rspamd-Queue-Id: 2D3FE212BDF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kudzu.us,intel.com,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,lists.linux.dev,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264398-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 05:19:30PM -0800, Jakub Kicinski wrote:
> On Sat, 28 Feb 2026 23:55:38 +0900 Koichiro Den wrote:
> > +static const struct ntb_queue_handlers ntb_netdev_handlers;
> 
> can we move some code around to avoid this forward declaration?

Sure. I'll do so by placing ntb_netdev_handlers() right after
ntb_netdev_tx_handler().

> 
> > +static int ntb_set_channels(struct net_device *ndev,
> > +			    struct ethtool_channels *channels)
> > +{
> > +	struct ntb_netdev *dev = netdev_priv(ndev);
> > +	unsigned int new = channels->combined_count;
> > +	unsigned int old = dev->num_queues;
> > +	bool running = netif_running(ndev);
> > +	struct ntb_netdev_queue *queue;
> > +	unsigned int q, created;
> > +	int rc = 0;
> > +
> > +	if (channels->rx_count || channels->tx_count || channels->other_count)
> > +		return -EINVAL;
> 
> Pretty sure core will protect from this since your get will return 0
> for corresponding max values
> 
> > +	if (!new || new > ndev->num_tx_queues)
> > +		return -ERANGE;
> 
> same, core should protect against this

Right, these are redundant as ethnl_set_channels() does the checks. I'll drop
them.

> 
> > +	if (new == old)
> > +		return 0;
> > +
> > +	if (new < old) {
> > +		if (running)
> > +			for (q = new; q < old; q++)
> > +				netif_stop_subqueue(ndev, q);
> > +
> > +		rc = netif_set_real_num_queues(ndev, new, new);
> > +		if (rc)
> > +			goto out_restore;
> > +
> > +		/* Publish new queue count before invalidating QP pointers */
> > +		dev->num_queues = new;
> > +
> > +		for (q = new; q < old; q++) {
> > +			queue = &dev->queues[q];
> > +
> > +			if (running) {
> > +				ntb_transport_link_down(queue->qp);
> > +				ntb_netdev_queue_rx_drain(queue);
> > +				timer_delete_sync(&queue->tx_timer);
> > +			}
> > +
> > +			ntb_transport_free_queue(queue->qp);
> > +			queue->qp = NULL;
> > +		}
> > +
> > +		goto out_restore;
> > +	}
> > +
> > +	created = old;
> > +	for (q = old; q < new; q++) {
> > +		queue = &dev->queues[q];
> > +
> > +		queue->ntdev = dev;
> > +		queue->qid = q;
> > +		queue->qp = ntb_transport_create_queue(queue, dev->client_dev,
> > +						       &ntb_netdev_handlers);
> > +		if (!queue->qp) {
> > +			rc = -ENOSPC;
> > +			goto err_new;
> > +		}
> > +		created++;
> > +
> > +		if (!running)
> > +			continue;
> > +
> > +		timer_setup(&queue->tx_timer, ntb_netdev_tx_timer, 0);
> > +
> > +		rc = ntb_netdev_queue_rx_fill(ndev, queue);
> > +		if (rc)
> > +			goto err_new;
> > +
> > +		/*
> > +		 * Carrier may already be on due to other QPs. Keep the new
> > +		 * subqueue stopped until we get a Link Up event for this QP.
> > +		 */
> > +		netif_stop_subqueue(ndev, q);
> > +	}
> > +
> > +	rc = netif_set_real_num_queues(ndev, new, new);
> > +	if (rc)
> > +		goto err_new;
> > +
> > +	dev->num_queues = new;
> > +
> > +	if (running)
> > +		for (q = old; q < new; q++)
> > +			ntb_transport_link_up(dev->queues[q].qp);
> > +
> > +	return 0;
> > +
> > +err_new:
> > +	if (running) {
> > +		unsigned int rollback = created;
> > +
> > +		while (rollback-- > old) {
> > +			queue = &dev->queues[rollback];
> > +			ntb_transport_link_down(queue->qp);
> > +			ntb_netdev_queue_rx_drain(queue);
> > +			timer_delete_sync(&queue->tx_timer);
> > +		}
> > +	}
> > +
> > +	while (created-- > old) {
> > +		queue = &dev->queues[created];
> > +		ntb_transport_free_queue(queue->qp);
> > +		queue->qp = NULL;
> > +	}
> > +
> > +out_restore:
> > +	if (running) {
> > +		ntb_netdev_sync_subqueues(dev);
> > +		ntb_netdev_update_carrier(dev);
> > +	}
> > +	return rc;
> > +}
> 
> The logic LGTM, but the function is a little long.
> Would it be possible to split it up?

Yes, I'll split it up in v3.

While doing so, I also noticed that ntb_netdev_sync_subqueues() does more than
necessary. In particular, re-syncing all remaining subqueues based solely on
link state is not the right granularity for set_channels(), and can also
unnecessarily override subqueue stop state unrelated to resizing.

So in v3, I'd like to drop ntb_netdev_sync_subqueues() entirely and make the
rollback behavior more explicit and compact.

Thanks for the review,
Koichiro

