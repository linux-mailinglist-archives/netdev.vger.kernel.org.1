Return-Path: <netdev+bounces-13942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F4073E238
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 16:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6AEA1C20362
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 14:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16AB79F0;
	Mon, 26 Jun 2023 14:35:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29DF8F56
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 14:35:29 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1494CE74
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 07:35:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SqenGstuqpvo5inaNuCIkeBbqj/SkR4L0kCJbRKtSXrd5JqoiGuHmAQJz/FAUa11BYCbwszOFZqqj13OP4fkYhwH272RFM5rtLdZW+WIHq17AtzdHvFOU2zV/aaNxR5DM+kV7CEUiF1mNT5NFbQyMIJBu4fidNW+wuD5hVkY+fgoyDOWb/9kCMlNmm8BGhs9mTtnB244+5H3nc/iXGgpAY4NUrTIJb2fFI1fBZ/+Tna9m57AinYsJxlDvbLgNpiM4h91dh2qG5CQ3ghkHPU4m3T+IVHAPv8WDc4mSQ6FEy7mV+5YMNsxO1avqVzldEbrUqJhG5r2iuEGItcyZ5gLhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=edutI84QRQSecC24bLe4E6TXCwt21TYPmRJeDyZvdVA=;
 b=kNOVSUBFgI8k4FXkZtNXl/EuBACvoBKFgl1Y3le7uWm36wrhlDpMngk1uHWyM3ozbWad7b+23MqNH63E2m4QB+YraC7KklxEnHs8RWEQQfzd88f/N7ypfy9XbZuR3S0VF3n5BHPrsYaCcPB4CfA+yNXBGGj7OStJuuQSInaYKNT56uzfu5GOTZ8REnbVYK30NsI9v0VBkHY6pUQ1Te2r7MzEM/OEc0EQ+lOVjmldPuMOfF9ajd5gRTWVy1L7ECd2XyRkVRJO2bP5BLieDG5CP2VM6C+0XRWercM1OilngwcWBr9+iCzVketYksJALKH6bl4AWIPfZSQdcmjt1PRkNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=edutI84QRQSecC24bLe4E6TXCwt21TYPmRJeDyZvdVA=;
 b=OLV/VA8vT6RoF0lJ/Y1uWqaHzx7gVrQZhe8qlEQWaIaVBPJC2AMsHTtTD4pazBRL+AnDKiMLULIOTwDy5CSKXBPuPzE0Ojm9I+rnA9QZ/fjLLsx8iJpV5m6TBqAZN2bBcBQrctgny/EUmIBnquW9LjtchbT8RSAbmDjLvtDslbdQ9bvRAE9WsuJvIDIy2IS1paH3M7JIYYuHoBAOYNq8tOa2bZfjQDc9HnfdIMjiLSA+2PADrYPm0BBJGI/YB3PwQABpaVlOEipP+DnLavJrugQjQQK1tzvjo7U1J+Cq5pB5Ru5zfBRiPn0K4Y3ICsruB1BLQj6s+p6UcijZ5Tuf9g==
Received: from BN9PR03CA0365.namprd03.prod.outlook.com (2603:10b6:408:f7::10)
 by SJ0PR12MB6734.namprd12.prod.outlook.com (2603:10b6:a03:478::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.47; Mon, 26 Jun
 2023 14:35:23 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f7:cafe::b5) by BN9PR03CA0365.outlook.office365.com
 (2603:10b6:408:f7::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.33 via Frontend
 Transport; Mon, 26 Jun 2023 14:35:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.47 via Frontend Transport; Mon, 26 Jun 2023 14:35:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 26 Jun 2023
 07:35:04 -0700
Received: from fedora.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 26 Jun
 2023 07:35:00 -0700
References: <20230620174423.4144938-1-anthony.l.nguyen@intel.com>
 <20230620174423.4144938-7-anthony.l.nguyen@intel.com>
 <ZJmgB9fUPE+nfmoh@localhost.localdomain>
User-agent: mu4e 1.8.11; emacs 28.2
From: Vlad Buslov <vladbu@nvidia.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<netdev@vger.kernel.org>, Wojciech Drewek <wojciech.drewek@intel.com>,
	<jiri@resnulli.us>, <ivecera@redhat.com>, <simon.horman@corigine.com>, "Sujai
 Buvaneswaran" <sujai.buvaneswaran@intel.com>
Subject: Re: [PATCH net-next 06/12] ice: Implement basic eswitch bridge setup
Date: Mon, 26 Jun 2023 17:31:14 +0300
In-Reply-To: <ZJmgB9fUPE+nfmoh@localhost.localdomain>
Message-ID: <871qhyuwa5.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT025:EE_|SJ0PR12MB6734:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bf2f803-89c5-4689-a840-08db765292f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Xq07wUWY0bmO7FkKQofcZdeSQLPwJUArd9XO0rMKofPd+4vt981BcliZYmHY5PMtcJXSU94F+qelcad2EH8B3KssEPw+CrZuKY2ynkyzaMMoD00DSHAr8dmU7nBs9roXyaE3msFmOtoA6URyqzjpD7A4S45e1O9tcnAhOFunRu3SUYePaeHgKrkceZPsxD5lktBTSjKo/+635J4/G5/6F5s1MaHVRoMJJ5B55hVC9FCHirKIfpGDcUz1qB11k65WuQhpemkbm2gWtY8TWirZbpdyFBKGZQP1gqZuNO4QJy5H+cJhOihzlpi40tttZEfGa+9tqgjYS1VZSODMcwf5y3cQ8osA8EcYCRbcEUP9I3SxQk5nwCvELjjfbn+4XteES5FOe0w3D5A8KSCu0RW1P4pnKgx0gFieEHFKlDVxjtaJ8u0vgppuIOhP+hVv54QYqt3wX1tD0e9gR8k1GXIFrPuLbYeK5gzPGtE4apjb7kMNhXtpyCfVZxbXm2GeunqnHu11aBP9K5mxbOy4UP7CVTDJT4nLQshaUcWPiRXvUEoZU/+/P0MPLI98t3WWyHv7KAlQdfTMLFszSKRkoh+JaooylGf044LZvryw2nfT7kl5YPAgMMQr1BhNx6QU4d3Z2/FO7XQ5+RO19P9lL2GACFhRi+Mi0+KHW45neig7VjaoXCcEoe5fKRp/gU8Lt35NvpKE2e6eQkged83wNrWbcvQycWzgD+IvHYd9HDHNpOXWIbhDQ+OygfJnW6cFW3bO
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39860400002)(376002)(136003)(451199021)(46966006)(40470700004)(36840700001)(40460700003)(7696005)(82310400005)(82740400003)(2616005)(356005)(7636003)(6666004)(83380400001)(336012)(26005)(16526019)(186003)(47076005)(36860700001)(40480700001)(86362001)(41300700001)(54906003)(478600001)(36756003)(316002)(2906002)(6916009)(70586007)(70206006)(4326008)(8936002)(8676002)(426003)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 14:35:22.6347
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bf2f803-89c5-4689-a840-08db765292f8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6734
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon 26 Jun 2023 at 16:26, Michal Swiatkowski <michal.swiatkowski@linux.intel.com> wrote:
> On Tue, Jun 20, 2023 at 10:44:17AM -0700, Tony Nguyen wrote:
>> From: Wojciech Drewek <wojciech.drewek@intel.com>
>> 
>> With this patch, ice driver is able to track if the port
>> representors or uplink port were added to the linux bridge in
>> switchdev mode. Listen for NETDEV_CHANGEUPPER events in order to
>> detect this. ice_esw_br data structure reflects the linux bridge
>> and stores all the ports of the bridge (ice_esw_br_port) in
>> xarray, it's created when the first port is added to the bridge and
>> freed once the last port is removed. Note that only one bridge is
>> supported per eswitch.
>> 
>> Bridge port (ice_esw_br_port) can be either a VF port representor
>> port or uplink port (ice_esw_br_port_type). In both cases bridge port
>> holds a reference to the VSI, VF's VSI in case of the PR and uplink
>> VSI in case of the uplink. VSI's index is used as an index to the
>> xarray in which ports are stored.
>> 
>> Add a check which prevents configuring switchdev mode if uplink is
>> already added to any bridge. This is needed because we need to listen
>> for NETDEV_CHANGEUPPER events to record if the uplink was added to
>> the bridge. Netdevice notifier is registered after eswitch mode
>> is changed to switchdev.
>> 
>> Reviewed-by: Simon Horman <simon.horman@corigine.com>
>> Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
>> Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
>> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
>> ---
>>  drivers/net/ethernet/intel/ice/Makefile       |   2 +-
>>  drivers/net/ethernet/intel/ice/ice.h          |   4 +-
>>  drivers/net/ethernet/intel/ice/ice_eswitch.c  |  26 +-
>>  .../net/ethernet/intel/ice/ice_eswitch_br.c   | 384 ++++++++++++++++++
>>  .../net/ethernet/intel/ice/ice_eswitch_br.h   |  42 ++
>>  drivers/net/ethernet/intel/ice/ice_main.c     |   2 +-
>>  drivers/net/ethernet/intel/ice/ice_repr.c     |   2 +-
>>  drivers/net/ethernet/intel/ice/ice_repr.h     |   3 +-
>>  8 files changed, 456 insertions(+), 9 deletions(-)
>>  create mode 100644 drivers/net/ethernet/intel/ice/ice_eswitch_br.c
>>  create mode 100644 drivers/net/ethernet/intel/ice/ice_eswitch_br.h
>> +
>> +static int
>> +ice_eswitch_br_port_changeupper(struct notifier_block *nb, void *ptr)
>> +{
>> +	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
>> +	struct netdev_notifier_changeupper_info *info = ptr;
>> +	struct ice_esw_br_offloads *br_offloads;
>> +	struct netlink_ext_ack *extack;
>> +	struct net_device *upper;
>> +
>> +	br_offloads = ice_nb_to_br_offloads(nb, netdev_nb);
>> +
>> +	if (!ice_eswitch_br_is_dev_valid(dev))
>> +		return 0;
>> +
>> +	upper = info->upper_dev;
>> +	if (!netif_is_bridge_master(upper))
>> +		return 0;
>> +
>> +	extack = netdev_notifier_info_to_extack(&info->info);
>> +
>> +	if (info->linking)
>> +		return ice_eswitch_br_port_link(br_offloads, dev,
>> +						upper->ifindex, extack);
>> +	else
>> +		return ice_eswitch_br_port_unlink(br_offloads, dev,
>> +						  upper->ifindex, extack);
>> +}
>> +
>> +static int
>> +ice_eswitch_br_port_event(struct notifier_block *nb,
>> +			  unsigned long event, void *ptr)
>> +{
>> +	int err = 0;
>> +
>> +	switch (event) {
>> +	case NETDEV_CHANGEUPPER:
>> +		err = ice_eswitch_br_port_changeupper(nb, ptr);
>> +		break;
>> +	}
>> +
>> +	return notifier_from_errno(err);
>> +}
> Hi Vlad,
>
> We found out that adding VF and corresponding port representor to the
> bridge cause loop in the bridge. Packets are looping through the bridge.
> I know that it isn't valid configuration, howevere, it can happen and
> after that the server is quite unstable.
>
> Does mellanox validate the port for this scenario? Or we should assume
> that user will add port wisely? I was looking at your code, but didn't
> find that. You are using NETDEV_PRECHANGEUPPER, do you think we should
> validate if user is trying to add VF when his PR is currently added?

Hmm, no, it is not something we validate. Also, I assume it will be
quite tricky to properly test for it, since user could try to add some
other netdevice connected to the VF (VLAN, tunneling dev, bonding, etc.)
which will probably lead to same result.


