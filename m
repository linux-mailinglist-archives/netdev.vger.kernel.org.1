Return-Path: <netdev+bounces-291181-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNICKkP0Empq5gYAu9opvQ
	(envelope-from <netdev+bounces-291181-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 14:51:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA345C26B5
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 14:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A31CA3012EA7
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 12:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8190E3955E6;
	Sun, 24 May 2026 12:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sVooBDza"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010063.outbound.protection.outlook.com [40.93.198.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39312395AEC
	for <netdev@vger.kernel.org>; Sun, 24 May 2026 12:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779627037; cv=fail; b=c97eVFw4b6kFT1YIJOiD8CbtC2aqRp77tG5vQ1N4vO2DJni7ytIHtsEa9F9oZsLHrt4gE4xo4J3NpADXIlu17kT4OdrCEHe0d84ww63ShMedAwRdPTglNEfYFLxsK0traiO7sDOhtFINfTUh9PZXapQUl4k4K7Q0SiF6gGLEq68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779627037; c=relaxed/simple;
	bh=L06v2NYEJ+sSKEeB7mY1zRoIdikfHO9Lfp50Xn+PtQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JSCw1ZYczXIB3almZ5V65NKyDLY5i63TXlRHQx8h+xDLDxTgdLGQ7SxpGpkriiOkrDDPtiknWzmeGCt+lZT6Om0BeLzuK/mKkl+9OgLC+426wFL5yPPb7GVxnVQ3zP9EaILZ3ZsBkSTkbhzvwYEY9cEIGJqxHIetFr0gHTUbTMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sVooBDza; arc=fail smtp.client-ip=40.93.198.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WmgOHm1WY/+mrWhakkehh4CCYzSRkVGfcR3tr7YqGcUhEyPzOk3Wi9/HNO5QWMfx1B3kHuKCh5ZJ8ed/bpLJIznM732ePp6lrJxuXKQNVj3ybbNE5ppV24mK4q2dJUJ51wCOzfrHwRpDGxj1p0De0lf8z0tgaKTwD26+k+FAVV/+PVvq/J4bobciYB5U0QCUUPT39cAiN8uZQxWYKiI+jT7Qu2DGX4OJetOPN7UbZ+mBWRWMgrnSPOv4oBofI5sNi3ttRj63yZ2rexPclBfUc8xuc2WMxEVI//fw7CfkMy/+tUM2I8mQWPAoq1J2F+EoREDwn7mv6FDr4+FBtZAFzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6LcKIJCaJcOo+h0dIZwq2RR8KwhmlqwSMHAd6WU5l+A=;
 b=PPpTcifQInLsrDQqAxZKNYv20gD2LUVsfoxOPmZ493r1CtAGNiQ/gZtmuozr4/H1E9ZLtMBWKyc1dBUkchc12rdNYuXYjxQ3EE4W6EuyC47+KZl9XWYVvv/Qk3qOV2vOV4rXZS1cOImXAoxIP7tSfEWRQqtkmQwgB/6IbQXfLnbaKnaSAZbEciv5oIeHRre3pbHinwgrKBCmUXnex4smQFe596l7l/cTq2lUyDIYC3A1t9ur4zQgYi4Y9TaaxkKDPDIdXHZI4z2hFoOO+rfa5+gCdS+TZw4xk+tZtbIjn0/XzOKaxUQBKgTBdGhj/D7Hzs7Yqd0Yk3te25phdmXjGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6LcKIJCaJcOo+h0dIZwq2RR8KwhmlqwSMHAd6WU5l+A=;
 b=sVooBDzaaLju5H9NCdED+MuxB2wlKfejjaUGQ6W+4Ep6ME5YJalemS6AnS8X6BIK8sO0eHMcXNtjUhx2xGCHH+PqEYS59jnK7f508vVSTK/R8zU2kaNtmru4UaOc/5QY9/p2ktvflngWckbSdJUPrEWTeLIS1XYi1Pyb11wPOnkMR8dLrbXa9oBAregEdrqRvzG/m8Ycx22lUZapC/V1PYJ0/wjg69usCKilCXNCZ9PCh7YM/xkEa1Q/8DFGj35/9TcegfNtqr6cfmS+W7Deq6C4cWBZiFYdM3I+lE5JhzZtEeNA2POM5NLw80gITm6LiShjnQ1Yb8s2wLL/Rfq7MA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SA1PR12MB7269.namprd12.prod.outlook.com (2603:10b6:806:2be::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Sun, 24 May
 2026 12:49:53 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0048.016; Sun, 24 May 2026
 12:49:53 +0000
Date: Sun, 24 May 2026 15:49:44 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 11/11] bridge: read p->flags once in
 br_port_fill_attrs()
Message-ID: <20260524124944.GK74116@shredder>
References: <20260521131916.3627204-1-edumazet@google.com>
 <20260521131916.3627204-12-edumazet@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521131916.3627204-12-edumazet@google.com>
X-ClientProxiedBy: FR4P281CA0043.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::17) To DS0PR12MB7900.namprd12.prod.outlook.com
 (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SA1PR12MB7269:EE_
X-MS-Office365-Filtering-Correlation-Id: 96f7c836-6e1b-46fa-0679-08deb992f32a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	/rqc+GMu46dq044xrFguO9j6qF9IvN25oUG8hx0DEBV+zYWJT5i7m9HbvFIrwYnqxz87ARCIn05vPpjscLUFLFDyJOj8vzBcdlpxVB/O8OGPR+noJ30H32Nl+S+I17g+JFcAzVHdiBIZLlluhkVaH0Dnqqy6CYXVrGOczfXYrltgVh8dVeHL2S85eJ0dN2JJFMG+XLP0HuQWpxCnpu++CuTxNL2OJa22ds86vaF5OTwWMRBsJy+bEg8ud4qrD9Z+jA9FCCZnXIQedDobHdwu2XMWZsRRip3S7Yr+Gl1q2yp5ZcyTjsh6SXoMxV4gwHdOkOMxT3eTxQl04yiz7VCiDYI6RJNMbOEh+rUA3IVuIYRh2tbVnoz+19wnGri2S3nfKgNefgqpaFQeST0wXzYmhTw5vpiBBXAn2ffq8v55wT8AYXf3Z9aBRz+nx5NncSG3v+b0NiVOQIjEtogqQueLcQ1J93gD/OJ/Q/AaL/xuFjx9mcn+yKzBUDGDq73eCURNhXU/2M73cWqZoHze8xmial1ZsEoh7g4fJZTju7aqZfEMT3KXHrWIMvmp6fF40/ZxO0w95b7oktaf9hLXDt4yLXH43IYpHqHI5D+Mb+uInya4z7Zl312uuLU89vbhLtIQx4Kh+LkOApInA0aJLt7fgqioszhz/1Le0m4C6aJuifLs9F/DnMqTyy0JUuuOK5Ir
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xOXhjQi4FPii15soYtQ/DL31NvbW5JNhQd+WipXAyzEWkko4DaqNui2wVb7L?=
 =?us-ascii?Q?h+ZmUn2BaIjFQJ//d1QazFLxnVPvkk1k3sd2w9jrthU+3Yq1mddDjepKdW8K?=
 =?us-ascii?Q?HUX3KmP6e1FlyDt+/DLfmHmxGDA+EB98akDPkg1LFXbqvaxpyCi15tKQ6zSI?=
 =?us-ascii?Q?QvSh5e1SG0qpCtRohgODV2YVSqP0HjjvUUEnY9IQUQAnftsDR+IvayjnVQW7?=
 =?us-ascii?Q?c5AkijiGkZDOnzfs1GZqZK3gunQsIaydBE++5U6zcVfnop6qeQw6VSzu7RwO?=
 =?us-ascii?Q?qeLI4tsfjusjfB/YHKoi2J26spHwfrx1WCJ2b6LVFc46XhRty5IcT/9Oj5Ei?=
 =?us-ascii?Q?pe2pY59i4j0ykON23p6vGmIgrPfVh5EZIogXsiKbnmPsCclIvgXqbbL00iA5?=
 =?us-ascii?Q?zmt79WlBPSzhfzlezFeVvxE6V8c2sNlpS2tlVQeocfOYduvF2JD7gX4uGb17?=
 =?us-ascii?Q?z/t453VZmfrQig0TDgF/crzjKRgZkBZsl4r0ofr8/DvFVWFoMGwfyt+4ndYc?=
 =?us-ascii?Q?HUYVH8PvDEjQLW19VpU5dvttx10aVLnG9XdM9rkGqQA7WzqOsjw1k3tD7xmo?=
 =?us-ascii?Q?rYRW5nVONtZhoRHV6lyjHTfM80nHXl/4GFQJi5Ui1xS0b9F0XXaBbz9JK/oQ?=
 =?us-ascii?Q?pMYXTAe1nd40sRRLUD6HhBHoIQ1Z9Q/fdOcq8R26k0z6rHvIYeVzFD4HXVwI?=
 =?us-ascii?Q?CxVzS7h6Sm3/4U6E5cHZj9oEYItOL8wEnPI7dJt3uROP6tE5rt4kbMA73upH?=
 =?us-ascii?Q?KASAGmb3WRpEfU+BnFIP71px8GHGT/K+udndsMo6jzzBXNJQJjJprfB48Yb9?=
 =?us-ascii?Q?LeKH81Sj1i7JFWK42kwJWO2qFIkkjWjONQIlMUZJvRClRx10MU0E6zgE3XKj?=
 =?us-ascii?Q?ZskRmi16faNr3KX4SEYZEvr/z49eRWL3rqCCwNrEWVBdc4Cm+qdy1R0CucK/?=
 =?us-ascii?Q?iCz9dwZU6n8XX+MkLALNLr1+7dJgrTKO/tN/+3Y9/OynLU7YznBD0A/snMjG?=
 =?us-ascii?Q?cLGkg+fHqHB3cyk91mk1mhRbBOKAFDUfBU6W3wAlBj+t9la9wQ6ZwM8wkJcJ?=
 =?us-ascii?Q?MWRdOM0Ci4MxJx8ybXt1AodHCfEuMMdQ8XDY/yAZqkjFpu8BkJ6VPifDai2s?=
 =?us-ascii?Q?lkPmu7TRQEPaM30ddJ09erYX7QAO8lh2/bGVg/rSiL41cUiWt5VEYLkLi/N/?=
 =?us-ascii?Q?+rgQ1/llZjLy78w8zQOisvJ/GwRdgo34Ns5Oij9UlZDU6PvYXnSiKGP7zbBt?=
 =?us-ascii?Q?Jm0qQ5qEYlLllGCwjj9IM9IoqIJ7eD6fMswZ+YJcvdGoO4lW3AdPv7kz9P+J?=
 =?us-ascii?Q?fBNS3nOMm8JdNNbO5RtKIfhXcQf+NQN2OvsItJvciYA60wpWfow4qb5FrGSd?=
 =?us-ascii?Q?raDzKKg7xOKOkgfj+kqERDo50XyBP4H8N3l7Nokv1YrCnolFRXXrBXkSbw+2?=
 =?us-ascii?Q?urll6J0DgTnykqxs6yoZuXw4sJ6uQttvysz+YFF0mw1aMcFobtgg2xfW2VhZ?=
 =?us-ascii?Q?R6VgznyfoDdi4lq3I1BRVrbRhf81nUFTVi4kwzQwHvZanGOImcRja1jcFYzS?=
 =?us-ascii?Q?syDVI8NB2PL+UNN43HyyyFwiDGH+SZBJdArx5PsMb4hnM7b3a1zvBlSTKK0b?=
 =?us-ascii?Q?cF770qy3WXcbgXsc1WdHRa7BJtzNORI1WxpMs4u0QvMtPeMJCaDResLEVBiN?=
 =?us-ascii?Q?EJgfbvnIyz4Ih1mTfs2UZ3fC7aaB7gAD/vcAtSXagZ6LgraR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96f7c836-6e1b-46fa-0679-08deb992f32a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2026 12:49:53.5526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KTuo5OfF1EhSQrS5/5sQ+JHUF6ED8avt8NZ6uyAxbkMCDe18v7eaRQ3q+5WF+6f98itciQDXtWrYEe8CIL5T9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7269
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-291181-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,blackwall.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1CA345C26B5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 01:19:16PM +0000, Eric Dumazet wrote:
> We might run br_port_fill_attrs() locklessly in the future.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

