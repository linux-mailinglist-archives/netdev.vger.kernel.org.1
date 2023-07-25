Return-Path: <netdev+bounces-21010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 960C5762254
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 21:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C71531C20F7D
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 19:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F83263DB;
	Tue, 25 Jul 2023 19:35:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82631D2FD
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 19:35:10 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1181FE5
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 12:35:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P5oxqJfUWZio2XCw6LiZly3Iy2k2Eaq4Y8PWKb1G5vk+q/8UWZO3zmhhsoVMNbyT3++cgEYFtZge+uyNHdMcYfcvUfIzmAeeaqDyNw/eU+NWX2XSj3dbqJBYqXPBGsXYKHSH1SDt6Y4mPZuRD+oDqQZOA0iX9NNjfIitYDVlxtgkBJIQycqd+e8QQsLtH5OMGtiK9McO9Ij9Ob2Pipr4bq7v0breoWNog65JngTMAS3NNh+RWsXgGDBxS8sst2BWOyz/cx5V9UFWRlvRyqm2DTtyWOu+xtNmCZOIYJFrmCykcMP4LvVk9Jh7cHui0qc4Gw2L3Uk0ORdt5Da0Dpspqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=62WJTXj1XiYMQohKcqGhNyoQR+NmQxpOL2PoWEwk7B4=;
 b=BNNkKK1Eub8YE6nyGY+n7Z7TkIjMBMQ3h3DaTHgVG2ml5PPTihDhGK8tI2pecmJA+Zs23amOvKUcvbU9XRfQ1d1qEG67BkXAwS4CsJxKMo8IloGA8NyqvZDkGvWevEgBIqPTrygXGzxSKxZbARg4aI7XcSoyuDr8F54Jp5uZcJzh767LWsYOAWTwnbQ9WhDoj5lAlBC4DDasTxUaWLLiz4r4ezJbegdrSYIPOzlo3yEd0do2jKwnpU5Ywqup4Tk2Qlr/VU21j6ZGFG0v4RJhElb1wliJjCu56FNkjuX04XhW1swgLWHD5yrNITGheWZbWKyyI/iLYM/FJ5iYaiaEYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=corigine.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62WJTXj1XiYMQohKcqGhNyoQR+NmQxpOL2PoWEwk7B4=;
 b=Xa3SuaYKDFdS/AXbBMl7tlEFt8ffDe7p0ObR+PzDgApvftH8QNOpDmDYNgcaGqZcdQbLrsihEGATgKfrhRuhXQdl2c4n3xjxOYd+qDndBJ26k+f56JSoPwqgWAHG8SrxaqvVwO51njdy7a1iFdMwH38TSoAZcuQHifIHqGsEoYcpYWyCq7ZhnlcArqxbi3DOdBfRtTagDL2XF7ugwqF79gAU9vgvQOFs/wG+N2pt968w80qkJdP2ZweSoPm4DmssJQG2JSizgBNxN/UO4VMCOHJn3hx8zgNj+33Mm4jaRKvAx+Lqul3EWXFBrRuqOJ8zvrCxQkjgWP5J/e+NabVDbQ==
Received: from MW4PR02CA0015.namprd02.prod.outlook.com (2603:10b6:303:16d::6)
 by DM6PR12MB4338.namprd12.prod.outlook.com (2603:10b6:5:2a2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Tue, 25 Jul
 2023 19:35:04 +0000
Received: from CO1NAM11FT072.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::c2) by MW4PR02CA0015.outlook.office365.com
 (2603:10b6:303:16d::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Tue, 25 Jul 2023 19:35:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT072.mail.protection.outlook.com (10.13.174.106) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29 via Frontend Transport; Tue, 25 Jul 2023 19:35:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 25 Jul 2023
 12:34:48 -0700
Received: from fedora.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 25 Jul
 2023 12:34:45 -0700
References: <20230724161152.2177196-1-anthony.l.nguyen@intel.com>
User-agent: mu4e 1.8.11; emacs 28.2
From: Vlad Buslov <vladbu@nvidia.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <netdev@vger.kernel.org>, <wojciech.drewek@intel.com>,
	<jiri@resnulli.us>, <ivecera@redhat.com>, <simon.horman@corigine.com>
Subject: Re: [PATCH net-next v2 00/12][pull request] ice: switchdev bridge
 offload
Date: Tue, 25 Jul 2023 22:32:18 +0300
In-Reply-To: <20230724161152.2177196-1-anthony.l.nguyen@intel.com>
Message-ID: <87pm4fss31.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT072:EE_|DM6PR12MB4338:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cb0c8cc-bce0-46d3-0143-08db8d463eab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GpYgyfV0WO0ghnPkn+p5KkCCutq+KZ4LHMUrh1H7l0qrgXYaPqbYuhue/IhakloTdRtCzpGvb/1GTYQ2rexT167Sx2boYfrO4q4ksDSNUyryqZklVOQpbyKlmJhjQggwN2UAPFkJrJ9jrRi/AZPbESeq7t/UCBCXsDIr+C2Fx9nFevu0jWlpzNvNyjjpU2xbqzBpRj2e+j8XGvSjpGi4OAdPGpYL6Vts8LhH9gXyJbodfR/8ZPJ1lzcblSuae6qqh0aO56wQW0OMLRIupmzl/+E0VwEqpWrtvDwlQZW8i7ZSiJXAZLpe+DT6bXc1Dx5reWh2O3yQKmT4/9YkKlYd9WiSQKyBYlbvtrvCPnjRfT1tWLmS9H7vptHTIMDRk7g8Ld0NbGfpqmyU8kojsTqCJFfBB9dxnAf0b3Gd7SVYLfmykplZO+Jdmk8Ua9K7ojjgnYUqsdv9aqQSZsu0gzt7LlScxWlIpi8E2jEGf88njEITa/+2aizwXD0DlFUtMttGcrFSDUW4IZ7FH8Sn7w0D4QjBskYzOXkKQuXTg9Sor/YunGIqwVWAf0LuEfl2xRtqkptyBpAW7UTJI5nXadZyKCHXaXbTp3r+UDrL5ul9n/n6BNYf0FVL+FgUbIFSBX90JTBCLJx1dwOUvrfdHCaB1pWKcIRTxA5TWwXmp/IU6WOzudjymMuofG/d2KNc/C4jL8+sz5wEI6SfMIjfQmWItmkCG35nV5CVbQzukVV+4TQWlSycdBkx2/S/DcSuZkFr
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(39860400002)(451199021)(82310400008)(40470700004)(36840700001)(46966006)(40460700003)(26005)(16526019)(336012)(186003)(36756003)(36860700001)(5660300002)(356005)(7636003)(8936002)(8676002)(7416002)(2906002)(40480700001)(82740400003)(86362001)(7696005)(6666004)(70206006)(70586007)(83380400001)(54906003)(478600001)(41300700001)(426003)(2616005)(316002)(6916009)(4326008)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 19:35:04.0741
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cb0c8cc-bce0-46d3-0143-08db8d463eab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT072.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4338
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon 24 Jul 2023 at 09:11, Tony Nguyen <anthony.l.nguyen@intel.com> wrote:
> Wojciech Drewek says:
>
> Linux bridge provides ability to learn MAC addresses and vlans
> detected on bridge's ports. As a result of this, FDB (forward data base)
> entries are created and they can be offloaded to the HW. By adding
> VF's port representors to the bridge together with the uplink netdev,
> we can learn VF's and link partner's MAC addresses. This is achieved
> by slow/exception-path, where packets that do not match any filters
> (FDB entries in this case) are send to the bridge ports.
>
> Driver keeps track of the netdevs added to the bridge
> by listening for NETDEV_CHANGEUPPER event. We distinguish two types
> of bridge ports: uplink port and VF's representor port. Linux
> bridge always learns src MAC of the packet on rx path. With the
> current slow-path implementation, it means that we will learn
> VF's MAC on port repr (when the VF transmits the packet) and
> link partner's MAC on uplink (when we receive it on uplink from LAN).
>
> The driver is notified about learning of the MAC/VLAN by
> SWITCHDEV_FDB_{ADD|DEL}_TO_DEVICE events. This is followed by creation
> of the HW filter. The direction of the filter is based on port
> type (uplink or VF repr). In case of the uplink, rule forwards
> the packets to the LAN (matching on link partner's MAC). When the
> notification is received on VF repr then the rule forwards the
> packets to the associated VF (matching on VF's MAC).
>
> This approach would not work on its own however. This is because if
> one of the directions is offloaded, then the bridge would not be able
> to learn the other one. If the egress rule is added (learned on uplink)
> then the response from the VF will be sent directly to the LAN.
> The packet will not got through slow-path, it would not be seen on
> VF's port repr. Because of that, the bridge would not learn VF's MAC.
>
> This is solved by introducing guard rule. It prevents forward rule from
> working until the opposite direction is offloaded.
>
> Aging is not fully supported yet, aging time is static for now. The
> follow up submissions will introduce counters that will allow us to
> keep track if the rule is actually being used or not.
>
> A few fixes/changes are needed for this feature to work with ice driver.
> These are introduced in first 5 patches.
>
> Reviewed-by: Vlad Buslov <vladbu@nvidia.com>

In my previous reply I meant reviewed-by for the whole series, not for
the cover letter specifically. Sorry for not being more clear!

