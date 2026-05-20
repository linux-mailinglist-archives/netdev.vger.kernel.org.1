Return-Path: <netdev+bounces-289787-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8D0/C6xYDWpuwQUAu9opvQ
	(envelope-from <netdev+bounces-289787-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 08:46:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E42F588515
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 08:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 97E2E304BD3D
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 06:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF817352F85;
	Wed, 20 May 2026 06:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GT9jUjeA"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013029.outbound.protection.outlook.com [40.107.159.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51828351C31;
	Wed, 20 May 2026 06:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779259365; cv=fail; b=Er5lf9hMfXH76zxPAyogtP/Sjli7YQiDwYIDKIEZjsPsEzcpXftPxaxNMU3Xy/98eeLfNGJhN95RaSU60HWLaG165fVZ0HFfmVuxaKz2e8h8Xgb2f4d6JbBhcNxsLjFn0xGbhZP0an/uNdIcL6y44h7gkLC9u7yNLSy1mfAz8Ig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779259365; c=relaxed/simple;
	bh=Iai30pW1Shd70L4JlwSQId+yZeeM4OLxgfm84JoJWjA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pjE/LGObK6U14vjnyQbep+Hvln3K9AmS0tYrkPgJ9nhbyLpapwDkJNoHWHSZN/h7BshnVO5ORHbYGpwVHpvWL3vVkPQyKP0wMa6QGwQFxziOdwqp3B94ELaj6ko7xEsSwhigslAONjfQ1ExiDkm778NTqMNWY1b/70CVoCZZ+Yw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GT9jUjeA; arc=fail smtp.client-ip=40.107.159.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VXvcRcvsPDU5l7ikuCAMSstNDdUSPnJtkpHZu3OedGssM2/WDuiFdlU+vRW//2bMhwxfGIGWYPL13rHIpaqYDVyu9DWbb+uuL66zHsc/oD9LtJ6CT9cKjbnpTeWuE2Ua+Nnrt3ami8iK52qFZ4zvTV9WAOJy0IoJcBkIXdHVnH8d4EjwJciuD/PDgoLJVz/HLxReL1r8rb4neX+3Gfaiqve5KzdA59/yGOUD3aZqQOKD+G5n1a+hQXOTUrsgnmDz6T1bzHmAOdRUMSG87+Tflymtb9z3XetcTwygd7kDSg+QhjXA3pE7c68pgPTUHF1qHZccs2Ae1q+WeGvb9itThw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=meHXnznMk/D+oKj6hJAkmmLSOfHCYLOIGtqlN45CEnY=;
 b=OWgGmXNBULyhIR4RSG34R76kpf+PVBe7N5a8EChW3fttHAJrjaWXtCORRL7jPIpRvfeSTtiNtlKStVlBpTbI8hJpayzVtHRVg2BsZFz6AdoUWmt3A9KkH/tsH1yeyJTyN91BZQMdlWCsYLT8GtmiYkR9C6Out+x4aIgnDfVXzCTiz0WqXdD56+8ob6663BrKZzMjdCdj+JQxmgg+bNLjLrYLitrdRkzy9dxuRNZIh3SJ9N7AtK5h79ausFR4paoWF/eDblhp401SUMndrt0wjwYTzUlSszbfc2BICnkqAnguVAPmzfbEdfWzxf9ANIxyObwB3e2C+zIpa1RmWOY7ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=meHXnznMk/D+oKj6hJAkmmLSOfHCYLOIGtqlN45CEnY=;
 b=GT9jUjeA3AuhJKpc3F7EgLHI7aDef0TgH78lQo87wN1zyYe7JhrOsQnP2PMA+xdRtm1JN4cODvM/ZNNjlLQKVY/2sjkKHjCIuUaVQb5t6hOTkYdgyaXWmR+rta9NAe7+KDncsJg7bhzaTGBkrCEbuOZoPnV0jIeUGuNnqAvdEYdbiIdrWP3E5Q+Fj9FOphNaVDnb92fUBTJFZ9mrP6gsTN6qzluwrZDNQna4mKR8ixQaN6tmtUH/U9pmQFZwyMDyQZp+GdInSn23K8pXekLwSWwrjmIcnTaQzp2xweYjw8SwNy8b8x8H3/dlYl8ImbSLcKltBbLwWYkwzwM0ertEfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by DB9PR04MB11659.eurprd04.prod.outlook.com (2603:10a6:10:607::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 06:42:40 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9913.009; Wed, 20 May 2026
 06:42:40 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	hramamurthy@google.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	catalin.horghidan@nxp.com
Subject: [PATCH v3 net 9/9] net: enetc: avoid VF->PF mailbox timeout during SR-IOV teardown
Date: Wed, 20 May 2026 14:44:21 +0800
Message-Id: <20260520064421.91569-10-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260520064421.91569-1-wei.fang@nxp.com>
References: <20260520064421.91569-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:4:197::10) To DBBPR04MB7500.eurprd04.prod.outlook.com
 (2603:10a6:10:1f4::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|DB9PR04MB11659:EE_
X-MS-Office365-Filtering-Correlation-Id: 92cd8012-2310-44b7-ee71-08deb63afd02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|1800799024|366016|38350700014|56012099003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	MwK+N1gKYxPN2q+krhqkfIXyrHujwWZIuadlVf3grPsJj5J6XlzfhnfYCvbSqFRbdSZfrfvOBb5W4ufNiJC/CXYb01csji9YwKJF6jpqeLa68F1sk0H70LeIiF498fW9ldGruxiFTjc2VMDBl2zejiT03Iox2TB4hHTatCOCZRiC1kHl+rdhU3mAsmVC+1g8O3NmoDjWZ7rUJPKjTMZJlBYAycL0yL4v774m+98pEAg+PPpLSKtqrolTj+rVIxua7G4x5JeO6q7f7BwuIDTqTgxmrFdxXtRpCNZQiaOj8fFyRnQw9abuzmkWeu2M27crVkjwWftz1CfnDTZfDVYnZtRVKO9m14eIiFl73OrbrryCzyGc7iAYvk2rhJD3CkoIG8xRD7u7Uu3ZsZp2FEG94RbGORi01KvWgtNJurQeDlFOJ6VlMU8pzeKCi0lSJNIFg3ipfnI9xCF1UxntWJCHa1HAFqWuI52ZMrXo+fEHNLCVXk4asoI8wIiRwgcF3iD4Vq+0sQH3juTVdxJktaT2YHbPH0U8IlRuZfSuySwLigx55hO/4NHQepxs4Ib0Rb+2Dv4jKKcP3eIsi2H/+oBTZxcQLNf4Gjovi+3u3e4MnN5Pt2VogznEs3LAuBySRK6qYNz7IzQKceiotnAYD09eyA3UKKRGujaxINC7W41fJBVjp2BtbVN+ghXOuTcssL5de77xGAIEw/JxpBPI/pGJOQRPgzd/sdmcs5PM2kV/y1RnQqAZRszJH3hKBzv5mVpE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(1800799024)(366016)(38350700014)(56012099003)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HulE00ExeStLK9Lb3jM48g9sWdzI/rJdDNLUOPvIsOWqbsjb2i6i2uVgoDAJ?=
 =?us-ascii?Q?2Y/1EkqFsJSQoBYJrW9FTivTA1HTJnmB4JtAXDkkOzFf58DrbbNECFqeAtjc?=
 =?us-ascii?Q?mmrz0NSKDUgR/SEdSpcoSs/rVJ7doJah4/O2gLOO8HUt6QvRGUTiS86uJoZy?=
 =?us-ascii?Q?bz7lk0fAfCFztjSSMY0UwsaVItgX7mHPfPw08uNkCaCGOsQfEbRauV0Ou6mo?=
 =?us-ascii?Q?Btqgz6qsvDrm/BvCnaGnFPIguHXl7yndBvnFholHd2rR9TkchIRydAu635n0?=
 =?us-ascii?Q?0XNvAxFAyhbgJ/dNDMw5ccYK2pbymqD5nlDr5bzx/7a2ukYZPRkXG1PRjG7F?=
 =?us-ascii?Q?uSv8ul+zHrdDVxwaZxkvXkZRI4BBPFY8PLY17AVlronmsHL4F09wvGoqRsgp?=
 =?us-ascii?Q?5LS2gU+/9GrUIdpQlr3WT4nG57tLce0ehxhiNMU2MgELf9b7E2EahelSEes1?=
 =?us-ascii?Q?3zmdMz0nmD7UjE+Qu3s0W/a+I93ZhSIB1ajDo7nIXZAtrRB2anm/XaNwhx0G?=
 =?us-ascii?Q?+97J57vaJUrfUH5KEHTlvUNoRH3vPWV8NZ0zOJbpNeMKlByAlQgMfkHZVw+G?=
 =?us-ascii?Q?GewZ8ZsMssAUzXdhI+DXIaKFF2UCzf+BO6VbiEID+BBZPj6XVIHawClh+dhU?=
 =?us-ascii?Q?/WZHzI+EkQ2nkK7VNZAdxixPNiv9m1lSx/+hfJrn6YbkKoIBgqqmYhIf+wip?=
 =?us-ascii?Q?JbenQGatOpCABCGbQdlfE/Zoh+s/e3cGCtVn+xl2qIyOLnqegcJUZhNxV5oc?=
 =?us-ascii?Q?zqrqscJb97uLmroJac3aDdp9Ngich/MqFPGFJffKYhAmEcee2K4h5rySrq75?=
 =?us-ascii?Q?VQhm0NvvBTBAZ9g/JcuhgaThLS5WBMZ/vzdz/UIRrdJ2oxEsu2XEy++zRBhh?=
 =?us-ascii?Q?hwy3xXUJ0QVSu69JTmM3P5Ja6cQY27H2GgWUFuqMxOEHHIQHCkSCB5dHeRDG?=
 =?us-ascii?Q?wi2YpHmustfMjiHwYRJ5EyPpRBfXimoDvhAS3H7PIJqMLkPjb6BA4ZzYOaTM?=
 =?us-ascii?Q?43sq/N9xUBs4i3BChArfpEunQ+LPCU1B1O6cxgfdrhbDtdHjdI4pwnFbHUTz?=
 =?us-ascii?Q?114i3JMBXPCqwkGFf0DcaXOpbC4ViYUBWwO1vhuyxfSpMIbbvlaGghJXbt3H?=
 =?us-ascii?Q?ltegoWRIm6HG3bo7MnSx0jU8cDrHjLpmgl73fKMIKkMgA8XuI2otWQvjOTYW?=
 =?us-ascii?Q?VhoBqO6zG3Nhbv5hlzus6mcksuwY/AdAv9/8PRdn7gBaC0m63N0ejSoYVI8z?=
 =?us-ascii?Q?PO0NiIGLz0U62YdyvVggSqqp2Xl2Yho9ATiE/nfvuiVo0iXnIwahOES9f597?=
 =?us-ascii?Q?cvsM4qumzgjTN6E4f/gQNfpc6ObwZ1bfrNI1N20vLhHK3uYqRja3VkwN92qQ?=
 =?us-ascii?Q?lTqUnknkAgaFKn1CKhvrRAdWvbNC6OnI197/2ajj44ACCBaejtLK27OUcjDd?=
 =?us-ascii?Q?7Hh1WcdX5peg+pLrQb+DpF3KoAsw/WBfd/kl3G/ht+jCJzy2jaUBZ2co/iKE?=
 =?us-ascii?Q?GCYQNn2/tFnYUdxCaRC1vIoVoTLDe1/VBWJFsPa8EwOGYFGx380Z2UpNg9L9?=
 =?us-ascii?Q?YjrX8jn18NKD5EGwLgKtpa/hy7md83/trmGjSNgYj1G6l+fJrOOdrk7C4jDu?=
 =?us-ascii?Q?hyPOEDLB4D3mFKwD+6elc7MaLl/gcQBafW3BSNLEFQmQ67RcBqYHrRCPxwYu?=
 =?us-ascii?Q?CmGYFBxtxe+VhKuqpwclW9phZZUa4cPv6GXU60RPL1URIySDwgOZwRK6RADi?=
 =?us-ascii?Q?rfudszjdcA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92cd8012-2310-44b7-ee71-08deb63afd02
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 06:42:40.7006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h9FwXRvo7iq9hHUB69oUd8jMUK7SmjetxCbJ5ma62S7oEtx3DoOl0Icchb3eiYtm8q5gIDhcZW4ffeUD+Spz+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB11659
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-289787-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:mid,nxp.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3E42F588515
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

During SR-IOV teardown, enetc_msg_psi_free() disables the MR interrupt
before pci_disable_sriov() removes the VFs. If a VF sends a mailbox
message during this window, the PF cannot receive it, causing the VF to
timeout waiting for a reply.

Since the timeout occurs during SR-IOV teardown when the VF is about to
be removed anyway, it has no functional impact on operation. However,
more messages will be added in the future, some visible error logs may
confuse users. So fix it by calling pci_disable_sriov() first to remove
all VFs, then safely clean up the mailbox resources. This eliminates the
race window where VFs could send messages to an unresponsive PF.

Fixes: beb74ac878c8 ("enetc: Add vf to pf messaging support")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/freescale/enetc/enetc_pf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index 8e11a023d516..3206b3daa1a0 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -563,9 +563,9 @@ static int enetc_sriov_configure(struct pci_dev *pdev, int num_vfs)
 	int err;
 
 	if (!num_vfs) {
+		pci_disable_sriov(pdev);
 		enetc_msg_psi_free(pf);
 		pf->num_vfs = 0;
-		pci_disable_sriov(pdev);
 	} else {
 		pf->num_vfs = num_vfs;
 
-- 
2.34.1


