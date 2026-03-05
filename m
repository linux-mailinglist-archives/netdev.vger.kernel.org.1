Return-Path: <netdev+bounces-264402-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHCKHf6LqWl3/AAAu9opvQ
	(envelope-from <netdev+bounces-264402-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 14:58:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A0F212E17
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 14:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4587D30A6EAA
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 13:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204AC3A5E90;
	Thu,  5 Mar 2026 13:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="s5bTzk35"
X-Original-To: netdev@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020119.outbound.protection.outlook.com [52.101.228.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDA83A5E7F;
	Thu,  5 Mar 2026 13:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772719007; cv=fail; b=il1OpjrbUylge2kIpJ/TzFnLYlCrS58idjZIRaixfILeqszM66dT7+GsoVKnienpuezXyhNmXjzOsrQW/8EEMyR9PiKE0G9txV32RIwGTqM3h03EiWKrH8+HGPqeyZ/Ug/09NfJndHS7sQGEokuvfNKHVlnfVr2HEJDnETRAZMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772719007; c=relaxed/simple;
	bh=5OkLm/GkSShY1Fq4K0a48TOPYfr0DglHEFopHt5cuYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mhBzgmpPE/1qbMWvZsWc+/nAaJ5SjNRQm+uYMU4eELJIeRGK2cH/p7UIuXGS3IVVvZ+tLJ272zcdokVspAc+chb5ZsP3X5STw7zKCuTHXU6BDRjjx13s59N+x/TCTIMqcpFNRfNAFEZimgoxFJZGH3wxt4B2DMqIjkdi28VEwB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=s5bTzk35; arc=fail smtp.client-ip=52.101.228.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cFOk1QCpuBidNo+X3QkfMVcyJP/RTW53rPQ3YxfwtKKpVOFolNLLPEX00sGYz9FAabdwLH2W5g+TRU5W8pJS+1cRl8WzKxduhcLI8KoVEUMmxOZKJnpnRobwdmqFjsyDcLXurgJOtXpV60JrXtOUFYO5dDJlGiyRk4/GteDWsL1BYLF3U8u4ZvbF8dE7Hqq9eS322S2Y6xlNSU/B5zGRgm+DxpX/mLnrLc/pHkoOKaHkjkFWiu3biVCPfxe8KPd6c1xv6jJXBdZ7D8EF2+XQ2OIK8iLNiG6VVuRQrRWhQsNjlePA4jV7Y+rCI0L1/X9IZlr1z6N3XX06CC4bSZ8Mdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lKANANiiQIhnM612j/SvRR1HTbTMGunzYNbwR0EfKos=;
 b=BdbLuxyaPoLDX8PXksp+ntF+Oy5rJ28RQt1UxuXpfdTEWAThd9Hhq9LYu4MwQNqxc0CLKUnVipXk3K0e6YMPn0cnLkPiNesbRAnTmMuYGddPWkms7kIDgLSR88vmOKsY5shSCacTp/5QMurEmN3eK0uBgXz5yJIjtfi/STRbhnOx6MMv8Bmp7ewh/xPNL+bo9MSQ5bFIQ9BcSJFMdRTlpZRHVJTCRPhcnvIu0P1tH/kydS2GqVtwJysGNghI2U3TTaXUbB6mXRdEAPsSbnvFvn/VhVUdS8Xgp7+k1CEtoUqlwddZmDnxxONYNgfeY94Cqf/VOflw08tBh/zMAS+hTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lKANANiiQIhnM612j/SvRR1HTbTMGunzYNbwR0EfKos=;
 b=s5bTzk35X6IUoM60UmdddUlRA44cngcZ8PEgglIWWBo0tfaJ7JXmtJ+YAP7Kj2RurdHrmUZG8+/WQ9s4xUCa/RjHftVhyE/cLYrUlBkA5sh0txSJAeGnL2xGMD6euDUxHTDQWx6rg1AZLnJ5Vf73xlSMFpGG5VG12TCCsmQiM7g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYRP286MB5198.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:117::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 13:56:42 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9678.016; Thu, 5 Mar 2026
 13:56:42 +0000
Date: Thu, 5 Mar 2026 22:56:41 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, ntb@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] net: ntb_netdev: Introduce per-queue context
Message-ID: <6xykduszznqrgjicryktaiw46izanrzinohtvdn3a3ezt4cv5u@v3fwtdhbh4z2>
References: <20260228145538.3955864-1-den@valinux.co.jp>
 <20260228145538.3955864-2-den@valinux.co.jp>
 <20260304171337.5bc44eef@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304171337.5bc44eef@kernel.org>
X-ClientProxiedBy: TY4P286CA0026.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::11) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYRP286MB5198:EE_
X-MS-Office365-Filtering-Correlation-Id: b4a7b647-d80a-4739-4553-08de7abf07f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	gtgV0t7lqY3XLy8CEGAmTmsh2EXT8jO+TD4ilv8yNd8Tj85/A+elrZoUPxZAkL5/PzHrp1esMB8UiGz8+f2F4TDmcPjitalm5Eer0Cufptzk/EfJqL8HcXfwNoICOHT0yTxyjZB3aDw/5LEoprAiAwGsxSfEp02PHfEcRJZaA0cZMbeVORGrN4OkQVZE3aHxiBrSuvDXgVf96Vwd1fWq+zfD9lo/N88dmtFxcAS6kiLO2Zrjn+jvq7eNyflDAqmIrr6p3tqE4qOMQu2IVSKNPbdHn+5AyR9huSrmKw1ZKqn+wAZNdZPYeF1SdcTqUWMl9nEKEp6GWAWnAPEoRY84IHGN6K9TsY3WnbJwIsNACLhcbzDHQ0IqraLzp1flSdXKyrGdgX1k0uKCDvCDpF8dCwXh9MqbP6LxRB4MYLhlsr/rjy9kDrz/xcl3Y7PiU7gh9IFDGRZo21Rio+8tBir3B8yCrKhEflnKP+ePNH1CkMtizY6Gm9KBoxJOez92Q2OYXihipgENOyMG/P6GoNDIX0z06QMV0Inw+CCpzrEpQSN2HadiMul5OByZVhKEnGkOflZNppIlILXc67GbtWtobTTgv7wa7ihpfMPM4+N32j3LkccVxoMbT2Tb/8P2UPBgRvLS9v1Zb+4FafuG4xsVZXEjSv5gvqSFCQEj4ghTK/gJtvb3ltxbZUjW/VYaIufqjd9yOjSKKLjJLnlWE1ChWhGT94Rf5e/lwybAHJPX85w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vuVN5di5f33JK8kTeGHCwpsomcMAesG4uqKNeG8ZrillB5tZ56F3IELa33hq?=
 =?us-ascii?Q?5ciIfKVklevwMO/6SfAsiRm+8GIk36HEL8V6spxMcWOPAuFn/bSgrE6KQi2R?=
 =?us-ascii?Q?vJt11vAcnFl+PfwYsHjxRiAqco6/YEGfBhEhjluCXvi5YDt6TDS72+S6g5pV?=
 =?us-ascii?Q?+wo3hna5NelMF1ZbIekYaiGnDs2VyAZyVpWY1PJKrWSvWrVZjQfvlwC+urA1?=
 =?us-ascii?Q?lGQd/xGiGKtT0MbkU1EdaQzHHxO3YvIkbLUNvCIBtsEhjhmDXqaK57UZUxfg?=
 =?us-ascii?Q?d6UnT7zfB+5835hUwJK5/UhXzu4Tx4EsLcYVF8nlq54EX6Dtmh30bIRxR/xs?=
 =?us-ascii?Q?dBSCveX5xK0NIcU8/1WlHaidotbj17aDoNFQzd04fbJ6OMg0ejT78YBi49Rx?=
 =?us-ascii?Q?saw7L3efeFOkIOB5XX1efRlLli4fmDvoV2dMWaRDFRD1+h6dFbYaPPsr+O5C?=
 =?us-ascii?Q?rmCuC3tWsaa4PDTqbVeJBgnm5ZT2m88oEaiDj5MrXFHKkTWJQkQX5UMZo/2A?=
 =?us-ascii?Q?L3CVY9hK65LiO24bt6cAlG/+b6eA1t4RFdyNUTVuwzgND9Xozx3RMTQK0q1C?=
 =?us-ascii?Q?AtWr96Ej92CWW/WvWF/7j+mJV/XIIRuzoOL/N99LRNxvZifrNayKA3Df2hdd?=
 =?us-ascii?Q?TCCU3sKKoNOgh2BzjtJ+CZ9hSzE1AcbLh+JBpJ8FENcvsgfkNApGi5YB1IKQ?=
 =?us-ascii?Q?nO3icSr7UYXcUslIsdK7nbot6hsG74m+uFL0sL1FLmz5ZMeYwVFT2/fD7ny5?=
 =?us-ascii?Q?/HrwZbU7QBAAtpO6LNiPJHaylrzA0vpqyjGNf/Q7oAhsgbVdHuE8cA/ThPoX?=
 =?us-ascii?Q?C/5N+FHwe/28sUJXdNO+KlUzEMbWXX6s9SiXHMgjtWM+aabxv6n5rtzufMkZ?=
 =?us-ascii?Q?mh/7iM+WQ3FTv0oViYvp5MyVXv85+nTejNFPTkBx9nuam0gEbb8L0Yh8/hLr?=
 =?us-ascii?Q?vDkrZxTwiBW/sx9N4jQukGdlevqW/T/USEfg34DKd2aGGjVC+Ee5Csfd3EXE?=
 =?us-ascii?Q?3K8Xq3IMRrSFreeLRkI+h4ow0NnO2/2yJR0tkcd0iA4CmgO2VLRz+MKcKLv6?=
 =?us-ascii?Q?mOrDjQohcmIwkUp8Qrkf4K8p8FtNVTHHy/YSTqxgLwDYdx57JMVxFd/X65WO?=
 =?us-ascii?Q?+AqxzThMEOjw1jvedbPSHK/SRIJDnJi/M+LTRIa4LxnYc6QrK4IhiXJgI4er?=
 =?us-ascii?Q?e9Y31hjp+3ZmlcW+qS/gftO4jZch6ZR8cXwiIFUJKF7BovfPY7DdUeeyRJKd?=
 =?us-ascii?Q?6JIz9lBnK23cxFfQHMacRpUi+jfTelHMYi0bRxMs0NwB3mNTDAyWXZceO3kJ?=
 =?us-ascii?Q?igftZ53iy36by7+wqlrcWUztyJ362ZaEkgJ333ZkJAXf+GbUTGX3eXPtD3Vx?=
 =?us-ascii?Q?NFhjqt6Bm88ejVZ/iPrNa4gKDUQ+2WZjEjcXxOw/t5Rj5QXRQlazN3EiT+iJ?=
 =?us-ascii?Q?WFov48xuEghx/ouPi0YKpO2FXvojzQuJLMD0QCJ47FSa8IxgyK3gWSeDeUTx?=
 =?us-ascii?Q?N35zkgh+ZnyZnyObd4UCjWDkysj9fTK3rZx1W2KiW6cW4wI3jjSppxuEkU24?=
 =?us-ascii?Q?dHG7K5ik7maYRmc1qZT0ZDXR6XplHjwO3RpzR9kWhJu41NhxtF9ee7Qi3fKA?=
 =?us-ascii?Q?uO6V6UTuEaxbqjqopRk96ee9ODLLvLatrPPjFJUVUl2dRN1IJ8AUGXHCxWYr?=
 =?us-ascii?Q?18+Rxt2PwA3SoM+P+q2jAx1F7j8KqUs3D3Yw2m4OJIRQxX7DiSOK6vY/md5w?=
 =?us-ascii?Q?fkeZbwBvZTf5mCtdX4GL+E/yWnGSBCbQD/WGkwWqZUZrk59RjaNE?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: b4a7b647-d80a-4739-4553-08de7abf07f0
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 13:56:42.4372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n8/pKWnAQ61iLbACOJXBV75PNnzYRomw+v++jsk/NPlRG+fDJwZImfuR0YiniA6/ffHhlFBuEd4vWaHr47Za9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB5198
X-Rspamd-Queue-Id: C1A0F212E17
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264402-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kudzu.us,intel.com,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,lists.linux.dev,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,valinux.co.jp:dkim]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 05:13:37PM -0800, Jakub Kicinski wrote:
> On Sat, 28 Feb 2026 23:55:35 +0900 Koichiro Den wrote:
> > @@ -99,7 +114,9 @@ static void ntb_netdev_event_handler(void *data, int link_is_up)
> >  static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
> >  				  void *data, int len)
> >  {
> > -	struct net_device *ndev = qp_data;
> > +	struct ntb_netdev_queue *q = qp_data;
> > +	struct ntb_netdev *dev = q->ntdev;
> > +	struct net_device *ndev = dev->ndev;
> >  	struct sk_buff *skb;
> >  	int rc;
> >  
> > @@ -118,6 +135,7 @@ static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
> >  	skb_put(skb, len);
> >  	skb->protocol = eth_type_trans(skb, ndev);
> >  	skb->ip_summed = CHECKSUM_NONE;
> > +	skb_record_rx_queue(skb, q->qid);
> >  
> >  	if (netif_rx(skb) == NET_RX_DROP) {
> >  		ndev->stats.rx_errors++;
> > @@ -135,7 +153,8 @@ static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
> >  	}
> >  
> >  enqueue_again:
> > -	rc = ntb_transport_rx_enqueue(qp, skb, skb->data, ndev->mtu + ETH_HLEN);
> > +	rc = ntb_transport_rx_enqueue(q->qp, skb, skb->data,
> 
> nit: I think in this case you don't have to replace qp qith q->qp ?
> qp is an argument of ntb_netdev_rx_handler()
> 
> > @@ -208,16 +227,26 @@ static netdev_tx_t ntb_netdev_start_xmit(struct sk_buff *skb,
> >  					 struct net_device *ndev)
> >  {
> >  	struct ntb_netdev *dev = netdev_priv(ndev);
> > +	u16 qid = skb_get_queue_mapping(skb);
> > +	struct ntb_netdev_queue *q;
> >  	int rc;
> >  
> > -	ntb_netdev_maybe_stop_tx(ndev, dev->qp, tx_stop);
> > +	if (unlikely(!dev->num_queues))
> 
> please avoid such defensive checks, this should never happen
> 
> > +		goto err;
> >  
> > -	rc = ntb_transport_tx_enqueue(dev->qp, skb, skb->data, skb->len);
> > +	if (unlikely(qid >= dev->num_queues))
> 
> same, the stack should not sent patches for disabled queues
> 
> > +		qid = 0;
> > +
> 
> >  static void ntb_netdev_tx_timer(struct timer_list *t)
> >  {
> > -	struct ntb_netdev *dev = timer_container_of(dev, t, tx_timer);
> > +	struct ntb_netdev_queue *q = timer_container_of(q, t, tx_timer);
> > +	struct ntb_netdev *dev = q->ntdev;
> >  	struct net_device *ndev = dev->ndev;
> 
> nit: if you can't maintain the longest to shortest order because of
> dependencies the init should be moved out-of-line
> 
> >  static int ntb_netdev_open(struct net_device *ndev)
> >  {
> >  	struct ntb_netdev *dev = netdev_priv(ndev);
> > +	struct ntb_netdev_queue *queue;
> >  	struct sk_buff *skb;
> > -	int rc, i, len;
> > +	unsigned int q;
> > +	int rc = 0, i, len;
> 
> nit: sort variable declaration lines longest to shortest (there's at
> least one more of such issues in this patch)
> 
> > @@ -420,6 +485,16 @@ static int ntb_netdev_probe(struct device *client_dev)
> >  	dev = netdev_priv(ndev);
> >  	dev->ndev = ndev;
> >  	dev->pdev = pdev;
> > +	dev->client_dev = client_dev;
> > +	dev->num_queues = 0;
> > +
> > +	dev->queues = kcalloc(NTB_NETDEV_MAX_QUEUES, sizeof(*dev->queues),
> > +			      GFP_KERNEL);
> 
> I think we may be expected to use kzalloc_objs() now
> 
> 
> > @@ -464,9 +560,14 @@ static void ntb_netdev_remove(struct device *client_dev)
> >  {
> >  	struct net_device *ndev = dev_get_drvdata(client_dev);
> >  	struct ntb_netdev *dev = netdev_priv(ndev);
> > +	unsigned int q;
> > +
> >  
> 
> nit double new line

Thanks for the review. All you pointed out makes sense. I've addressed these
locally and re-tested the series. I'll send v3 later.

Best regards,
Koichiro

> -- 
> pw-bot: cr

