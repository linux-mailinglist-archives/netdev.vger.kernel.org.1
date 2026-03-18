Return-Path: <netdev+bounces-269072-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJ/PFAbCumkGbgIAu9opvQ
	(envelope-from <netdev+bounces-269072-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 16:17:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C28932BE05D
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 16:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0188E33483AD
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 15:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E53B3DFC9C;
	Wed, 18 Mar 2026 15:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="M0+xreWy"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011018.outbound.protection.outlook.com [52.101.62.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8323DFC6C
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 15:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773846281; cv=fail; b=LWvPbY7EQc1yS+HE4Tr5a58YLkW+d/kYiq85vX1roaMgqPvAMX8AaCbIhvxkhDJNDiTxMvRIxoI6PuMIXC7fD6YBlmpithJFKi10Ccx44yZAh1+eh8rtP14UscTbiebI96XjDchOFoZpTanz5Nj8Oof6VtY9s/p9xZ75z/HWNME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773846281; c=relaxed/simple;
	bh=RLnd1vqOsVZQurvF2YkyOp5UibAHAs2p13b3ZTn3CZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e4sZPVecCuS7aQScSkUotYomJqg4xXf0vOh101z2qOPdanwtWAkQccUM74CGDriywEUIFYsSuhdAO+13FZRxqzuOikLa7zauBiDGXMUsza8Nx8cZp98iunDI1s7DsadN95dq5cOHnwGg0P01Cn/icb+NdT66asHUIxJ7jeef+Cw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com; spf=pass smtp.mailfrom=gehealthcare.com; dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b=M0+xreWy; arc=fail smtp.client-ip=52.101.62.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Seeo945aH5mKIqGRG3Jq91xQu6M6NMGB6nFtE7j+6Tz0PmT3hd0zvZkyWKu9qX7/R0sNSBxzb/ySaFSD0qNFlHwGfecF3739Knv9vw+qBKv1+NHXVKN1HxO6YfkYkqMjsrK3iV/rvNPizbezCqEIfftYi6QNbYa/ZrrNqUFWTVhpBqP+keO7b206OPaRbhrVzvVdlS9laAzcoJ1RoCd5lnOXhARJrcfhmDW1cnw3Y+BzgQs93/iRGL+2LS6TD/ar7YzwCRG6XU0N4M83agBG1oRzEE4/sYA5uoWysRb2eUD/IbXuXtRRCByajc9pVTjhe0CN+ZUWIzrVwkhwVmE4aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YBrY5e7l+6plSzqx4kijk5esDf7cUbNYBn2fZ1d7sZ4=;
 b=Ow4ELAhGp6ascjkDOO1FDzn8HbP+2C8mIhHxIA0kVejmxpmfeL68A9QSEb2DHR1j5q8bLjQsKzusm/nr0eiP7Qza3I1B95ShGPHxL/cTz+kcq89VtlyBw3Dnl+bGKku/PfZL7WFlTLfWXj0UPWViyyIppv3IeKuO3TUA3r/I+GhAI38DHfk0b3WT9NEnhOvT+b+hD83SGvE+t1F06N+DLdflegIoNC8KPeW7Tmb68FFE3ko7R9LeFCtlMI1B8OdwXld25hWsJ0u8vO5LWvJPne2hvuyqWxrVu2Hk4fv26TGkDX6TdbTkz8SDDcX1YOaMiqewdVx5LYuXWgEztjBaBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBrY5e7l+6plSzqx4kijk5esDf7cUbNYBn2fZ1d7sZ4=;
 b=M0+xreWy45k80osbKNnpMNEKNuDvCB2IGd9V8jBlY2ZUdDxhjyEsqzGVqwGuRed8VyijDFXRwV6Vm5zpsOyNii6t//sp44+EMqE5HlkrYEYxX3/fDB1YuSwiotpN06a6exoJxmTBL1pVT/at49ZWFb0GU33fCL4Q+MfVq32dFCXgIEVNTlZACUfAp9oGapct7RVWLrmimkGguAQsBZjsNlN+xf/hlc4SyCun5aUt0R0ZcRmNdRXCACEbu1AQLG6raJfpLoqnVg8u8DFBv4DdWQbgYN1K89Ey6EfeIbiznX8XVgq/MdpbQ2cBd5GoENlLjqRMT2TKOe7NLOpSiMS2jQ==
Received: from CH0PR03CA0325.namprd03.prod.outlook.com (2603:10b6:610:118::31)
 by MN0PR22MB3642.namprd22.prod.outlook.com (2603:10b6:208:376::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Wed, 18 Mar
 2026 15:04:34 +0000
Received: from DS3PEPF0000C37A.namprd04.prod.outlook.com
 (2603:10b6:610:118:cafe::8b) by CH0PR03CA0325.outlook.office365.com
 (2603:10b6:610:118::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 15:04:06 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=atlrelay1.compute.ge-healthcare.net;
Received: from atlrelay1.compute.ge-healthcare.net (165.85.157.49) by
 DS3PEPF0000C37A.mail.protection.outlook.com (10.167.23.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 18 Mar 2026 15:04:31 +0000
Received: from zeus (zoo13.fihel.lab.ge-healthcare.net [10.168.174.111])
	by builder1.fihel.lab.ge-healthcare.net (Postfix) with SMTP id 2C29FD9C13;
	Wed, 18 Mar 2026 17:04:29 +0200 (EET)
Date: Wed, 18 Mar 2026 17:04:28 +0200
From: Ian Ray <ian.ray@gehealthcare.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	ilane@ti.com, linville@tuxdriver.com
Subject: Re: [PATCH net] nfc: nci: fix circular locking dependency in
 nci_close_device
Message-ID: <abq-_ATeXRYpVCEU@zeus>
References: <20260317193334.988609-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317193334.988609-1-kuba@kernel.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37A:EE_|MN0PR22MB3642:EE_
X-MS-Office365-Filtering-Correlation-Id: d60d469f-40f3-41c1-a301-08de84ffa913
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	wNfMjYgEwnhVYvBALx0c36xuDugcPkUExDtOrGPS+80w2fj6mFpcfsGl2dzy9Qi5bD0p4iFaXiRAbpG0ZtVd0+Mp4FDNMUqYGP97rQ5Sn36il9csTUvI5hPif+jSvNtugdzSM2Yc58/1/uaoSiUsdu01tV5RCWqqtdTD51wxHMb90XCiiHaNQKw9wTIKT3M2G5xJatQ9mgWj8XdrltsE+wlw9MPT+arwqq+3qZyZ/cTP765pzU1XmVSFXjqUv4/3eC3yxJKcoCK+80uumpjmKTxzsS8+m+oUxtw220MuECAtTRHMOoRnPPP8Wls81vojhaFiCY0Uv0LzDF6Q+Txq1mJF/lw2FMIuaI69ItuUNC5pwpmLGuIIRjLTW64uffNizS5idRl/qadKO/2qo/MCEc8pupZ+wctImoRLGsWkItYKWgfZyj5rqh2WvgQWuhB+j6rolUC/TT837oEXyhJ/tWugX9fDBVwQQcsyoD8MwLC2nZBF6YKfCNAxjY80019Ry8bbNpwWFo3JdrzNe7TXNn2xq1DPW211AJFUEGi7jSRpplKLFuLJhaPx3MLMiu+zQumjJzIQIR9MmQnISQMwHQ4UtIkg+FnN+aI7ISa6E9jj1Pa+2LnFGeqcsB1eczS87iLMDYT7bDtyU/3yG07xjbizKlOL/DBuB0FUBij8uqGIOvfXzz3LQ33ankmeR04a8vAhruEov0ea+6rNgX7zP+7W795/UW3Cw1t0e1e57moXdGgZx3SbXoHaFXrmsWqtGDmmFTakcJFh14MOj1gj2g==
X-Forefront-Antispam-Report:
	CIP:165.85.157.49;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:atlrelay1.compute.ge-healthcare.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wpk+Wse6eI/N9VBbNSwAoyFd4znUFVXxp9rzhemFT4fJ2aVovGuHnVblM9aqnPouRBRXm2al4Y+qzq0wiUyGb4CAUDgJpGAkXxLJihIfStpfK/soFFhXQqR4DaF2coExzFjVPQ3jJHXedGg9MuzXL93lGbPXDPnVzcoA0ol44300RenqId8WSd4ZFLu8JP84naOwYyQMLRH5SDYf+LW/zILs6VRa/r3t1ztWozNPYoWJkHrYfbIKe5GTRoh28JtSfAoUvEZlhttRcg8DWMAigDbyloZ1dmBCY6WBWuPtTl7LDi8rs5cCVp/1mASt1BsNYRy2H/BHy0Np3kQphLMvSTMmPtiZIzVjXOfGYWLMGep2vPMr7Q9uwo1b454RVJXuhrmpylf5RZMUJw32psT5ndT7ur9N61wldrw3UGrOTNN+0fWj+qa+d27NKFzD4s9L
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 15:04:31.9366
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d60d469f-40f3-41c1-a301-08de84ffa913
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf;Ip=[165.85.157.49];Helo=[atlrelay1.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DS3PEPF0000C37A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR22MB3642
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gehealthcare.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gehealthcare.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269072-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tuxdriver.com:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gehealthcare.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ian.ray@gehealthcare.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.978];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C28932BE05D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 12:33:34PM -0700, Jakub Kicinski wrote:
> nci_close_device() flushes rx_wq and tx_wq while holding req_lock.
> This causes a circular locking dependency because nci_rx_work()
> running on rx_wq can end up taking req_lock too:
> 
>   nci_rx_work -> nci_rx_data_packet -> nci_data_exchange_complete
>     -> __sk_destruct -> rawsock_destruct -> nfc_deactivate_target
>     -> nci_deactivate_target -> nci_request -> mutex_lock(&ndev->req_lock)
> 
> Move the flush of rx_wq after req_lock has been released.
> This should safe (I think) because NCI_UP has already been cleared
> and the transport is closed, so the work will see it and return
> -ENETDOWN.
> 
> NIPA has been hitting this running the nci selftest with a debug
> kernel on roughly 4% of the runs.
> 
> Fixes: 6a2968aaf50c ("NFC: basic NCI protocol implementation")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Ian Ray <ian.ray@gehealthcare.com>

> ---
> CC: ian.ray@gehealthcare.com
> CC: ilane@ti.com
> CC: linville@tuxdriver.com
> ---
>  net/nfc/nci/core.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
> index 43d871525dbc..5f46c4b5720f 100644
> --- a/net/nfc/nci/core.c
> +++ b/net/nfc/nci/core.c
> @@ -579,8 +579,7 @@ static int nci_close_device(struct nci_dev *ndev)
>         skb_queue_purge(&ndev->rx_q);
>         skb_queue_purge(&ndev->tx_q);
> 
> -       /* Flush RX and TX wq */
> -       flush_workqueue(ndev->rx_wq);
> +       /* Flush TX wq, RX wq flush can't be under the lock */
>         flush_workqueue(ndev->tx_wq);
> 
>         /* Reset device */
> @@ -592,13 +591,13 @@ static int nci_close_device(struct nci_dev *ndev)
>                       msecs_to_jiffies(NCI_RESET_TIMEOUT));
> 
>         /* After this point our queues are empty
> -        * and no works are scheduled.
> +        * rx work may be running but will see that NCI_UP was cleared
>          */
>         ndev->ops->close(ndev);
> 
>         clear_bit(NCI_INIT, &ndev->flags);
> 
> -       /* Flush cmd wq */
> +       /* Flush cmd and tx wq */
>         flush_workqueue(ndev->cmd_wq);
> 
>         timer_delete_sync(&ndev->cmd_timer);
> @@ -613,6 +612,9 @@ static int nci_close_device(struct nci_dev *ndev)
> 
>         mutex_unlock(&ndev->req_lock);
> 
> +       /* rx_work may take req_lock via nci_deactivate_target */
> +       flush_workqueue(ndev->rx_wq);
> +
>         return 0;
>  }
> 
> --
> 2.53.0
> 

