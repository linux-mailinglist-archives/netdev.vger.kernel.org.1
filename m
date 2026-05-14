Return-Path: <netdev+bounces-287970-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8L2fL3fSBWpUbwIAu9opvQ
	(envelope-from <netdev+bounces-287970-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 15:47:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6188654279E
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 15:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8AE51302532D
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 13:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410C23E867A;
	Thu, 14 May 2026 13:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Bvg68aAv"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011055.outbound.protection.outlook.com [52.101.70.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A763E51DA;
	Thu, 14 May 2026 13:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778766426; cv=fail; b=mi3hELyshlx/4QwSvot1K2vD9V2E88Oo+tpo2tnRlfuOn4gHg2GSMm1UsxRFYkNykKxT/Z90RvSRb0gACrtIJWMMGk0Nxw43yMsc7xbVCEiSLbXMwLumQr7rMIdak6Jp3hkUMwuHwdUz2ItzfDDNygRI+2OcicB+ao7Pu6LBHcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778766426; c=relaxed/simple;
	bh=WPHdfjaEFWH4obNpUWzWpZ5F5izQcx1DaXEEhwC96oA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ooAuWV0o7UEaC+u2Lj06mf/w7MhMPtfwd3pcKlKCB4h7UXIJB7WHsZYTfX+GbH7GM+u/os2FglQmztzNq6PZGWVUR65OIHwD4bXWvkj/8k6jZe4vAFSbZ4D+wsFlDaMhzYiKR7C/LhPyCamrbPEPqHziBOCSZu0G8QCSN5VqcZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Bvg68aAv; arc=fail smtp.client-ip=52.101.70.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aPBxfAjdYc4iW3eCrIyCAMJ4yIJ1A1SKYTIs9EaZODwFYIfnraFuUw1DwfMAXSq9cNn1fNBhMDyBaFoxtcLnvMWcdWdkugs1GpC2PjDkcBqu2pqiDrpPe2LkEhPmqGk6kXEfReobIRrVEqar4D7q5gP68SUXZnO4/0Xrw3sedEX8DKEEvxclU3/FbJ9DJaLz+bfUCvEHTwdyCTXT7l+NfjTETFRFeuY2Y/B1gPOaf10G3htMj2OLV14mQ5LLKbRIuIZ5hoIoqB/D/vX5L2MPRlNtoYihn4meSsCI3LKZIIUsSchenMA51LYNVxp1XBI0biUeuHYf9O/5tl83vtJ1Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GqnlHflu7EotsraGrHDi3nq7Fec/00hewPzTRk514YQ=;
 b=g99UDPY1yIo4mKWpC29Xc0S9Aos4ieD1IWzT/x1w5BhWkmRz80OXw47MJRHz+UkgK/F/cN9v2DmABEJjOiGDnEAK/DKxRLNZoAWEUKhxkkGx2DLj0Eq1x4h3KIsXRp0PJkLbg1WeY1ZU7gFKN7uuFdNOU5ZoDktroVpvii9pq3Eg7lBPEcDerApMU0hh6DeajvRmjskjrFE5TKb2KJRmrqcRUV50c46xORUVWcV45nKfdkzgU8vyn740Hlb37ByAyuLZMvT3hqOLxF/UnVipEPb6IsE4JKjZcij79FTgUy+N0T6U7IswEbjOrcEjlTwRmk95tj2KmACfjXO/7+Al9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GqnlHflu7EotsraGrHDi3nq7Fec/00hewPzTRk514YQ=;
 b=Bvg68aAv+RvS8Jenlp+G185EcXRkj3kINuE/vbIOmpCC1UsIjRdSsOQgSV7W4qETeSZDx8RHD8tKBWZN66kFGp38wl5VW429RcTDjaQhKn7X9DudWuRVGPjo5BWco0HYd8VypqzUVR80ebvtS15cJFthAmnXnu7tbkXM5qDZSBCIkMf+Af5pSn0Gg8CbJjW+quswQks9qWXnKKuOOM3RbyBavQu1p/NzUr4eiWcxot3V7egVi3B4XEBz54ETtYfhbAmRl/Nxcz3kw/VHevFFTxCnGaIRJDdk91MS5oJKGqv95EIOvrgUN0Kv8XZB7sILqKko5HZhbLD2Q+MI4ydgZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PR3PR04MB7402.eurprd04.prod.outlook.com (2603:10a6:102:89::16)
 by DB8PR04MB7051.eurprd04.prod.outlook.com (2603:10a6:10:fd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 13:46:58 +0000
Received: from PR3PR04MB7402.eurprd04.prod.outlook.com
 ([fe80::4129:7aed:b5cb:b13d]) by PR3PR04MB7402.eurprd04.prod.outlook.com
 ([fe80::4129:7aed:b5cb:b13d%5]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 13:46:58 +0000
Date: Thu, 14 May 2026 16:46:54 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 09/13] dpaa2-switch: offload FDBs added on an
 upper bond device
Message-ID: <4ksim6ykjbe2aycu35fljbmslvvqcbngf7ax2jxa43us6tphja@u7kbal3clzci>
References: <20260512131554.952971-1-ioana.ciornei@nxp.com>
 <20260512131554.952971-1-ioana.ciornei@nxp.com>
 <20260512131554.952971-10-ioana.ciornei@nxp.com>
 <20260512131554.952971-10-ioana.ciornei@nxp.com>
 <20260514104655.vrn4bkrahimqpcgv@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514104655.vrn4bkrahimqpcgv@skbuf>
X-ClientProxiedBy: AS4P189CA0056.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::26) To PR3PR04MB7402.eurprd04.prod.outlook.com
 (2603:10a6:102:89::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3PR04MB7402:EE_|DB8PR04MB7051:EE_
X-MS-Office365-Filtering-Correlation-Id: 33bc0e75-e198-42f1-660a-08deb1bf4477
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|19092799006|18002099003|22082099003|4143699003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	5aRp0z9RLcegfQtDoca4ZvG/pCxEdoMacBhAWeL4WwMHpmIo8kNMC6ph0yxPIDoxA71+9fk3B5unme6j5RhUks2b8cq0X+yFM0Ezn9IFW0iBU1nhvm5hcmzItG8aIp7UWv4ilwQHktziVr6ozsgQWOF8H/h/2JgJHquNDHB8kBw2j5d5lNNXvNuVGSa5LXWAuYCdwLQ6xzTUtaDDyt44UTBz1Lk4rOYiF+7eMDp7NlANZbzb6nrGHEG3gp67mGwDfmQjogqBoal88GqnveFeAv1nMpHlS4m0KYPkOKyhwO9MRBbC3EAibwnP9oLY0N2xBIENdeYfswew2WSeOrWL0IFn23Far4635VpbuuVJTqXJaz09Utt2bq04DZjcb6lpOxP5hN/PCbiaTe1z18L4On0gAaVOxGL13AA/feyDH1xBcloFooaT2E/7fpkmFVcYkckv0ySALCCwM3+OZWQ1qu8ltMowZc1K2/F/Mfhv+pemEMIZX9d5NTPCRc2mwaNp762WaWDAjt9AwGdzhI13M/Mu0SGoaD3S34rMeydVvB5KihFoGsokGPAEoCXsVH3DlTbCHLkRrxdu64lBQufZaIlyIHcs7ALQYMssAHX00mdOK0SYSlcZj5Br8I1B7rxAe068YfQhO/YWNzrVUsgTMFyDPH+eZK6yjAKBYZIFSNpjdYu0EDAdHTf7utg6WxmT
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR04MB7402.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(19092799006)(18002099003)(22082099003)(4143699003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XlwB4im5Rrh6bHyqd0rmVSUs9jJm+r0gsRHKMuRVGHkqg0cw9korRkl1rnj4?=
 =?us-ascii?Q?ZXiRR5IcQsaanCcxbAFf+Ejj0sKKh6ixyM0XC7scyLbmq/dq7yRMyy3NWNAy?=
 =?us-ascii?Q?RAeqUy3CpPWu/ay6/EFuCrLXWKs19XFfCcPknmNfSAxsrgEa2vX16L1d3xv9?=
 =?us-ascii?Q?ainPZnyhsP3iVcBQ/9E519imv9IptMACcMlROYh/VAsGooAWkfoq4rHbbrM/?=
 =?us-ascii?Q?2MaYiVmrAfQbcyWB8aHz0Iuvd+XcGvp/p0oo0cZqf95kII42ryELxdxV+FnH?=
 =?us-ascii?Q?rZCkDz0/su42tNlN82Hk306xWAdQoNAOw3DFLW6Pg0Y5q6MpFC9UNzxiNBD/?=
 =?us-ascii?Q?R/OsiJOmJmWTDXejpHn0I4qqzMMucf2pMLf/t6LtsGDjZbWjYmrtlXsS1lYn?=
 =?us-ascii?Q?3JKNJRZnTKGBvRCpO79F/DseJ2ItsZWKs5PH8/uWMza+qLqWswGXTjrAQBX9?=
 =?us-ascii?Q?U6Cw7TXqsebWWEpk4splRS5owwEThQYOjJw+yahCg5YhzSlXXneOJCWiQ0LZ?=
 =?us-ascii?Q?j0Z9JE3ZKKJHWH1UoItbwJ4OqpI0fx1OCilXeTZ9ZpnS/S+9U9XdEX6yDXsT?=
 =?us-ascii?Q?WaG/MflDC436SFvyQ/iXyu84bblF3eYu6sZAZde//YTd0csJz/bjkeXz1lTU?=
 =?us-ascii?Q?XsESA9a2T4ynlcXuV/th8AY1nlw/d4OQzZCXCY4Rtuwzqnu5A0CJnTIpnZa3?=
 =?us-ascii?Q?kl0VE1Rk4AIQ4TMRk+TYbc6oU3S9qWIIHhaj9dCPufqRLf6/7ghdvo85IxC9?=
 =?us-ascii?Q?d4E0bheyeuRzN7ATdkKY6/5xvFpkry2yOn76m9+n+goc6DVSnLw9dH6cfaYc?=
 =?us-ascii?Q?sliTho+IdZ0m3jHh9rUaOYGQyNpoH/dyIIRj6Oai0Bx0twROwukfIKitNTew?=
 =?us-ascii?Q?FknbX7cRQfP2hJdNDia48tMostooqIS5IDpbzi8dfOKF4Ke8p/mFHMRs07fu?=
 =?us-ascii?Q?Dxwn7l3eYJcdMIZdaJNbAMhbqIunCtcXqAg4YNhO43FlxaUaJo31iuIO5nZw?=
 =?us-ascii?Q?4rde3/8XRNCo6K4R5yTBf6xJ5FZy58FfVrnANvnI2PzeuAS8QOTyuyKWdVIA?=
 =?us-ascii?Q?TT59e3NMAPDFdglPswkNmCyw27Hc/4ogFnKJ6pwwOpUfnh2Gg2SzajmEZ4XA?=
 =?us-ascii?Q?A5BqXFgNhi88xyEGKMjZdFLQVQijr8vFa4sPDJuUh3/SIKMbmRezIk65RiRa?=
 =?us-ascii?Q?T4lvUS3Wt9yursotBcbJ6Gcl1o7hruoucw59eEfpBGg6fz+OB4OnbP0DRSSo?=
 =?us-ascii?Q?e54q8q9hWJStccKasZGA3/VrGUzAuPTCd2MqQgrnU4Oq3cRIskdUYZe11znF?=
 =?us-ascii?Q?YNpUdNafljxMTITf7XrC4YPPq+tmem5JYIudMan6HzSGBBirsM3czvq3eKQE?=
 =?us-ascii?Q?ZpVPlIufCC9oV21Rzk8YGa1dduWNmrmG2n+vczgoTcddk5MbV+oY/70kBDZ7?=
 =?us-ascii?Q?px8Z6oCsQmMziV15cCa6OWHpjSIi953fVMJV+jfYs55TgGix4ndO+HegVreX?=
 =?us-ascii?Q?vibv3Frj3gMEaQYmQGP2StsJf7E3QsAa9hrZN4S+8y5hJjgx2VidDOoe43tD?=
 =?us-ascii?Q?A98Q20lgjStf2GHa5vn+0oSrtRz0oRTqRbomC2hvUQppU9iXCkEemHynrfAF?=
 =?us-ascii?Q?EcaH7e0dVexkeoj74Kug/C8tNjN3W8XQJhPidHBWEkeDxZhdJA553rqJIhc3?=
 =?us-ascii?Q?3uyn7W13HhL3xEohKQ+wjeh45gUnAfY+l65tKTBKi4W+MunlGYEiUCLKJ4XN?=
 =?us-ascii?Q?EqWpJo6Krg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33bc0e75-e198-42f1-660a-08deb1bf4477
X-MS-Exchange-CrossTenant-AuthSource: PR3PR04MB7402.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 13:46:58.0602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ufyCxBo1zfjRcKzljPcwU0/hQ6MAeJJcuvuqc5ZvnCsSsYMWC/qJ5LU9VFgcWWB72hmEHaGV95mQsE01N277xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7051
X-Rspamd-Queue-Id: 6188654279E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287970-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, May 14, 2026 at 01:46:55PM +0300, Vladimir Oltean wrote:
> On Tue, May 12, 2026 at 04:15:50PM +0300, Ioana Ciornei wrote:
> > +static bool dpaa2_switch_foreign_dev_check(const struct net_device *dev,
> > +					   const struct net_device *foreign_dev)
> > +{
> > +	struct ethsw_port_priv *port_priv = netdev_priv(dev);
> > +	struct ethsw_core *ethsw = port_priv->ethsw_data;
> > +	struct ethsw_port_priv *other_port;
> > +	int i;
> > +
> > +	if (netif_is_bridge_master(foreign_dev))
> > +		if (port_priv->fdb->bridge_dev == foreign_dev)
> > +			return false;
> > +
> > +	if (netif_is_bridge_port(foreign_dev)) {
> > +		for (i = 0; i < ethsw->sw_attr.num_ifs; i++) {
> > +			other_port = ethsw->ports[i];
> > +
> > +			if (!other_port || !other_port->lag)
> > +				continue;
> > +			if (other_port->lag->bond_dev == foreign_dev)
> > +				return false;
> > +		}
> > +	}
> > +
> > +	return true;
> > +}
> 
> I noticed Sashiko says:
> 
>  Does this misclassify a non-LAG dpaa2 switch port as foreign?  For a
>  plain "bridge fdb add aa:bb:cc:dd:ee:ff dev sw0p0 master static",
>  br_switchdev_fdb_populate() sets info.dev = sw0p0 and
>  __switchdev_handle_fdb_event_to_device() calls
>  dpaa2_switch_port_fdb_event() with dev == orig_dev == sw0p0.
>  Inside dpaa2_switch_foreign_dev_check(sw0p0, sw0p0):
>    netif_is_bridge_master(sw0p0) is false
>    netif_is_bridge_port(sw0p0)   is true
>    the loop only matches when other_port->lag->bond_dev == foreign_dev,
>    but sw0p0 is not a bond_dev, so no entry matches
>  so the function falls through to "return true" and the FDB event is
>  dropped without ever calling dpaa2_switch_port_fdb_add().  Pre-patch the
>  equivalent path only required dpaa2_switch_port_dev_check(dev) to be
>  true and would have installed the entry.
>  The new dpaa2_switch_port_offloads_bridge_port() helper added in
>  dpaa2-switch.h covers both the LAG bond_dev case and the direct port
>  netdev case:
>    static inline bool
>    dpaa2_switch_port_offloads_bridge_port(struct ethsw_port_priv *port_priv,
>                                           const struct net_device *dev)
>    {
>            if (port_priv->lag && port_priv->lag->bond_dev == dev)
>                    return true;
>            if (port_priv->netdev == dev)
>                    return true;
>            return false;
>    }
>  Should dpaa2_switch_foreign_dev_check() also consult the per-port netdev
>  match (e.g. via this helper) so non-LAG bridge ports aren't classified
>  as foreign?
> 

(...)

> It would be good, however, to do what the LLM says and fix this by
> saying that if netif_is_bridge_port(foreign_dev), the dpaa2-switch
> port %dev is foreign to it if there is no other_port under ethsw which
> has either a lag_dev _or_ a netdev equal to the foreign_dev. This way,
> the driver will be prepared when the switchdev_handle_fdb_event_to_device()
> algorithm changes.

Sure, will add that check also. I can directly use the
dpaa2_switch_port_offloads_bridge_port() function on other_port so
that it's more straight forward.

if (netif_is_bridge_port(foreign_dev)) {
	for (i = 0; i < ethsw->sw_attr.num_ifs; i++) {
		other_port = ethsw->ports[i];

		if (!other_port)
			continue;
		if (dpaa2_switch_port_offloads_bridge_port(other_port,
							   foreign_dev))
			return false;
	}
}

> 
>  dpaa2_switch_port_event() is documented as called under rcu_read_lock().
>  This loop reads other_port->lag and other_port->lag->bond_dev with no
>  synchronization, while those fields are mutated under rtnl by
>  dpaa2_switch_port_set_lag_group() and the bond-leave path
>  (port_priv->lag = NULL; lag->bond_dev = NULL).  Pointer reads are
>  atomic, but the compound (other_port->lag) && (lag->bond_dev) is not.
>  Is the foreign/native classification stable under concurrent bond
>  join/leave, or should this rely on RTNL / netdev adjacency RCU lists
>  instead?
> 
> I think this is valid. DSA has closed this race with the dsa_flush_workqueue()
> call placed after switchdev_bridge_port_unoffload(). It ensures that
> pending FDB events are all processed while the netdev adjacency
> relationships have not yet been destroyed (running in prechangeupper
> context).

I think that what you describe is a slightly different issue than the one
outlined by the LLM. You are talking about a race between the workqueue
processing and a changeupper event while the LLM talks about a race
between the dpaa2_switch_foreign_dev_check() execution and a changeupper
event. This race happens before any work item was even queued.

If another port in the switch is leaving a bond device while we are
executing dpaa2_switch_foreign_dev_check(), then the worst case is that
we could hit a NULL pointer. To avoid that I can rewrite the
dpaa2_switch_port_offloads_bridge_port() as:

static inline bool
dpaa2_switch_port_offloads_bridge_port(struct ethsw_port_priv *port_priv,
				       const struct net_device *dev)
{
	struct dpaa2_switch_lag *lag = port_priv->lag;

	if (lag && lag->bond_dev == dev)
		return true;
	if (port_priv->netdev == dev)
		return true;
	return false;
}

This way, even if port_priv->lag is changed to NULL concurrently, we do
not end up with a NULL pointer dereference.

Any other lack of synchronization between the foreign_dev_check_cb and
the changeupper events is benign for dpaa2-switch since the driver does
not do anything with the foreign FDBs.

