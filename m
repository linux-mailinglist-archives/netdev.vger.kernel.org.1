Return-Path: <netdev+bounces-13046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C68773A083
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 14:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 501F71C20A9E
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 12:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4090A1E512;
	Thu, 22 Jun 2023 12:07:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC141D2DD
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 12:07:36 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061e.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::61e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FCD171C
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 05:07:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RppEnMqepDTpZfs8sGUQRuaiv//D5LSkvrFRmbyNA67jY559p7nh9E/gdZlH+LJmsK7Ob1eUHjJ5BVfwUZ+BX6YZbrQv4k6gvjpLgPRjV04ZIwi08mAGje2j0Pe5t5YnTcUcueeVPYd+0+FfyvaThbJKnuZl+WXvQ1UQTmIJ0Ry6jvi6SRj2j/RDQsIey2RtAms48qbO1FRcuAP70gtc9GFZMm2g+E4mB9Xrq5rN5399pr7ZV7b6j3DkVHL2Icql11WZB3GPskoHduR3J56MRYeU63A2ZW4drGFkOs5/qhWIFru94sOD4CKLb0UGtzEOhquILUZqVEgPUUBmxJXUuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FkxXil0yPFH8CnHKyuSSG8cO1Qptv3BdqHl0QMRgWTM=;
 b=RHF8HKWySwwDZcygj14dT/fIbFI1YhrMr7CbS+0whRDHAqfg2E9OcDUnVVXVck4SKSCDwQEET554QjhTvr4dWK1eIWOJE+7BmW3l6usyRQQBj9SpJkod8c7TGXRvmddqnIN1yNlW71NbiB+6bVZgUNix/5rfYb2erwAHiJfqq5ul1gcmdD09GSAfZyxRlgoihcn09YUBxqUhNHq0jGMqBiBGmBMhUsHAFMoM/CqaDHIdRfPU5wpN9zTwPk+UrwXAKAfa9C11DNyTDvTnMLW02+Tmm9Fmvk6bDnhpoDe9PMmFOnSxbd3PeMawaeYAHx9PEzbFywsbW9U0BTu6Mlga+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FkxXil0yPFH8CnHKyuSSG8cO1Qptv3BdqHl0QMRgWTM=;
 b=aboqyfEfOKtJJINaCwvbGxieFWXa30NbwxLR7LqIwEOJ26z3ZbtQTypRLX1lKDGBqYcMVsYId5x3O/Lrla+LyUQx+wwrDvot9thkfM5hadkP86fcGFXKksFaxLFQiqox5pz0OlCrNxjSblYVd17IO/7vbqTAQpXdWEld2BLBvAKVHTnpLSOeSgf2RogT87WDM4Tx3Tvp+10CIan0mYiZHq63jUTI/jvTsD7Lv+xIml+vpzid9Htnj7FB0/4PiMStXmij84+Cif1TOqE5tGQtjJa/z/UXkHUnVUtopeYAp68FC5Ibr/wPQe9dsNfD9b8F+61cQM6nWsRYy6XQttiq5w==
Received: from MW4PR04CA0120.namprd04.prod.outlook.com (2603:10b6:303:83::35)
 by CH3PR12MB8307.namprd12.prod.outlook.com (2603:10b6:610:12f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 12:07:28 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:303:83:cafe::33) by MW4PR04CA0120.outlook.office365.com
 (2603:10b6:303:83::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 12:07:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.17 via Frontend Transport; Thu, 22 Jun 2023 12:07:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 22 Jun 2023
 05:07:10 -0700
Received: from fedora.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 22 Jun
 2023 05:07:07 -0700
References: <20230620174423.4144938-1-anthony.l.nguyen@intel.com>
 <20230620174423.4144938-10-anthony.l.nguyen@intel.com>
User-agent: mu4e 1.8.11; emacs 28.2
From: Vlad Buslov <vladbu@nvidia.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <netdev@vger.kernel.org>, Marcin Szycik
	<marcin.szycik@intel.com>, <jiri@resnulli.us>, <ivecera@redhat.com>,
	<simon.horman@corigine.com>, Wojciech Drewek <wojciech.drewek@intel.com>,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: Re: [PATCH net-next 09/12] ice: Add VLAN FDB support in switchdev mode
Date: Thu, 22 Jun 2023 15:03:39 +0300
In-Reply-To: <20230620174423.4144938-10-anthony.l.nguyen@intel.com>
Message-ID: <87a5wrvgyf.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|CH3PR12MB8307:EE_
X-MS-Office365-Filtering-Correlation-Id: 0791d00c-1709-4144-62ca-08db73193ff6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	B47TEYeuJNH0cW6az2diS5+hmr5EuR0CAXuJ+VZYMOAElBMdo8OClIC5an7E+Fek5zmkudoUm47j6KTALCixGOQ6F72aiL7GOtn+Vo0lNWqQMnx/hsN7yEzbEdKNKkeRfi/HFo+SfnJ2hznVZICvwJPYxsiabM3iH3IBj2Q69hBSxe62O/yROCNoDrplQppdi3TyLtk2ykbjdTpx4NThYU52F8XjKExqs7jzpv4o8WsVBYmOEtuHmUNvPrqVRchsOgz2BUu7ObYlt5sJo3aLWdO+eAMwL4CZuyfw473GLPnibY9x8x7tK1Svm0cCXrYA1uE3qkcVIEaNPQeLqBlOHWSWoMXJWijxKzLwiEPPV+Myc/H6MS20029r71zaR3I0csgfNgPRDXssJF2W5bftfLJCWw82A1tm89WNC/dANJ1GuhSntb1UeVdsSHtUMQa5vyBc5ZRWamkAXB5ZhPHVkNuA8Ox+qRJjVlC6APbvfeh/ZNiggPZ5i8hCAc6HktMXgTOg7lFnitgueQmugC2Uorg3MuPC1WJLaN41P90OEWu9AKZST1kXI2ypk2b5zZad8J5kwbgAJW/QZQUr8bBxa7HoRi10zsoyss4Jqo/D380hvVdb5EQy/u0gL8ISy+DcaI4B0Zp6RT5uSwEHjtJoWzXG71CZ/orz061sot9ssGPdPS6ZJIL5z3FmMhlP0hQSPSbsUhgUSXXnSDn+YmYrn/ArgR1Q2DutqjpWtoMXF+M=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199021)(40470700004)(46966006)(36840700001)(70586007)(54906003)(7696005)(478600001)(6666004)(70206006)(16526019)(26005)(82310400005)(30864003)(2906002)(186003)(8676002)(316002)(6916009)(86362001)(4326008)(8936002)(5660300002)(7416002)(41300700001)(356005)(82740400003)(7636003)(36756003)(40460700003)(47076005)(336012)(83380400001)(2616005)(36860700001)(40480700001)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 12:07:28.6451
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0791d00c-1709-4144-62ca-08db73193ff6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8307
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue 20 Jun 2023 at 10:44, Tony Nguyen <anthony.l.nguyen@intel.com> wrote:
> From: Marcin Szycik <marcin.szycik@intel.com>
>
> Add support for matching on VLAN tag in bridge offloads.
> Currently only trunk mode is supported.
>
> To enable VLAN filtering (existing FDB entries will be deleted):
> ip link set $BR type bridge vlan_filtering 1
>
> To add VLANs to bridge in trunk mode:
> bridge vlan add dev $PF1 vid 110-111
> bridge vlan add dev $VF1_PR vid 110-111
>
> Signed-off-by: Marcin Szycik <marcin.szycik@intel.com>
> Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_eswitch_br.c   | 296 +++++++++++++++++-
>  .../net/ethernet/intel/ice/ice_eswitch_br.h   |  21 ++
>  2 files changed, 309 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch_br.c b/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
> index 1e57ce7b22d3..805a6b2fd965 100644
> --- a/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
> +++ b/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
> @@ -70,16 +70,34 @@ ice_eswitch_br_rule_delete(struct ice_hw *hw, struct ice_rule_query_data *rule)
>  	return err;
>  }
>  
> +static u16
> +ice_eswitch_br_get_lkups_cnt(u16 vid)
> +{
> +	return ice_eswitch_br_is_vid_valid(vid) ? 2 : 1;
> +}
> +
> +static void
> +ice_eswitch_br_add_vlan_lkup(struct ice_adv_lkup_elem *list, u16 vid)
> +{
> +	if (ice_eswitch_br_is_vid_valid(vid)) {
> +		list[1].type = ICE_VLAN_OFOS;
> +		list[1].h_u.vlan_hdr.vlan = cpu_to_be16(vid & VLAN_VID_MASK);
> +		list[1].m_u.vlan_hdr.vlan = cpu_to_be16(0xFFFF);
> +	}
> +}
> +
>  static struct ice_rule_query_data *
>  ice_eswitch_br_fwd_rule_create(struct ice_hw *hw, int vsi_idx, int port_type,
> -			       const unsigned char *mac)
> +			       const unsigned char *mac, u16 vid)
>  {
>  	struct ice_adv_rule_info rule_info = { 0 };
>  	struct ice_rule_query_data *rule;
>  	struct ice_adv_lkup_elem *list;
> -	u16 lkups_cnt = 1;
> +	u16 lkups_cnt;
>  	int err;
>  
> +	lkups_cnt = ice_eswitch_br_get_lkups_cnt(vid);
> +
>  	rule = kzalloc(sizeof(*rule), GFP_KERNEL);
>  	if (!rule)
>  		return ERR_PTR(-ENOMEM);
> @@ -107,6 +125,8 @@ ice_eswitch_br_fwd_rule_create(struct ice_hw *hw, int vsi_idx, int port_type,
>  	ether_addr_copy(list[0].h_u.eth_hdr.dst_addr, mac);
>  	eth_broadcast_addr(list[0].m_u.eth_hdr.dst_addr);
>  
> +	ice_eswitch_br_add_vlan_lkup(list, vid);
> +
>  	rule_info.need_pass_l2 = true;
>  
>  	rule_info.sw_act.fltr_act = ICE_FWD_TO_VSI;
> @@ -129,13 +149,15 @@ ice_eswitch_br_fwd_rule_create(struct ice_hw *hw, int vsi_idx, int port_type,
>  
>  static struct ice_rule_query_data *
>  ice_eswitch_br_guard_rule_create(struct ice_hw *hw, u16 vsi_idx,
> -				 const unsigned char *mac)
> +				 const unsigned char *mac, u16 vid)
>  {
>  	struct ice_adv_rule_info rule_info = { 0 };
>  	struct ice_rule_query_data *rule;
>  	struct ice_adv_lkup_elem *list;
> -	const u16 lkups_cnt = 1;
>  	int err = -ENOMEM;
> +	u16 lkups_cnt;
> +
> +	lkups_cnt = ice_eswitch_br_get_lkups_cnt(vid);
>  
>  	rule = kzalloc(sizeof(*rule), GFP_KERNEL);
>  	if (!rule)
> @@ -149,6 +171,8 @@ ice_eswitch_br_guard_rule_create(struct ice_hw *hw, u16 vsi_idx,
>  	ether_addr_copy(list[0].h_u.eth_hdr.src_addr, mac);
>  	eth_broadcast_addr(list[0].m_u.eth_hdr.src_addr);
>  
> +	ice_eswitch_br_add_vlan_lkup(list, vid);
> +
>  	rule_info.allow_pass_l2 = true;
>  	rule_info.sw_act.vsi_handle = vsi_idx;
>  	rule_info.sw_act.fltr_act = ICE_NOP;
> @@ -172,7 +196,7 @@ ice_eswitch_br_guard_rule_create(struct ice_hw *hw, u16 vsi_idx,
>  
>  static struct ice_esw_br_flow *
>  ice_eswitch_br_flow_create(struct device *dev, struct ice_hw *hw, int vsi_idx,
> -			   int port_type, const unsigned char *mac)
> +			   int port_type, const unsigned char *mac, u16 vid)
>  {
>  	struct ice_rule_query_data *fwd_rule, *guard_rule;
>  	struct ice_esw_br_flow *flow;
> @@ -182,7 +206,8 @@ ice_eswitch_br_flow_create(struct device *dev, struct ice_hw *hw, int vsi_idx,
>  	if (!flow)
>  		return ERR_PTR(-ENOMEM);
>  
> -	fwd_rule = ice_eswitch_br_fwd_rule_create(hw, vsi_idx, port_type, mac);
> +	fwd_rule = ice_eswitch_br_fwd_rule_create(hw, vsi_idx, port_type, mac,
> +						  vid);
>  	err = PTR_ERR_OR_ZERO(fwd_rule);
>  	if (err) {
>  		dev_err(dev, "Failed to create eswitch bridge %sgress forward rule, err: %d\n",
> @@ -191,7 +216,7 @@ ice_eswitch_br_flow_create(struct device *dev, struct ice_hw *hw, int vsi_idx,
>  		goto err_fwd_rule;
>  	}
>  
> -	guard_rule = ice_eswitch_br_guard_rule_create(hw, vsi_idx, mac);
> +	guard_rule = ice_eswitch_br_guard_rule_create(hw, vsi_idx, mac, vid);
>  	err = PTR_ERR_OR_ZERO(guard_rule);
>  	if (err) {
>  		dev_err(dev, "Failed to create eswitch bridge %sgress guard rule, err: %d\n",
> @@ -245,6 +270,30 @@ ice_eswitch_br_flow_delete(struct ice_pf *pf, struct ice_esw_br_flow *flow)
>  	kfree(flow);
>  }
>  
> +static struct ice_esw_br_vlan *
> +ice_esw_br_port_vlan_lookup(struct ice_esw_br *bridge, u16 vsi_idx, u16 vid)
> +{
> +	struct ice_pf *pf = bridge->br_offloads->pf;
> +	struct device *dev = ice_pf_to_dev(pf);
> +	struct ice_esw_br_port *port;
> +	struct ice_esw_br_vlan *vlan;
> +
> +	port = xa_load(&bridge->ports, vsi_idx);
> +	if (!port) {
> +		dev_info(dev, "Bridge port lookup failed (vsi=%u)\n", vsi_idx);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	vlan = xa_load(&port->vlans, vid);
> +	if (!vlan) {
> +		dev_info(dev, "Bridge port vlan metadata lookup failed (vsi=%u)\n",
> +			 vsi_idx);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	return vlan;
> +}
> +
>  static void
>  ice_eswitch_br_fdb_entry_delete(struct ice_esw_br *bridge,
>  				struct ice_esw_br_fdb_entry *fdb_entry)
> @@ -314,10 +363,25 @@ ice_eswitch_br_fdb_entry_create(struct net_device *netdev,
>  	struct device *dev = ice_pf_to_dev(pf);
>  	struct ice_esw_br_fdb_entry *fdb_entry;
>  	struct ice_esw_br_flow *flow;
> +	struct ice_esw_br_vlan *vlan;
>  	struct ice_hw *hw = &pf->hw;
>  	unsigned long event;
>  	int err;
>  
> +	/* untagged filtering is not yet supported */
> +	if (!(bridge->flags & ICE_ESWITCH_BR_VLAN_FILTERING) && vid)
> +		return;
> +
> +	if ((bridge->flags & ICE_ESWITCH_BR_VLAN_FILTERING)) {
> +		vlan = ice_esw_br_port_vlan_lookup(bridge, br_port->vsi_idx,
> +						   vid);
> +		if (IS_ERR(vlan)) {
> +			dev_err(dev, "Failed to find vlan lookup, err: %ld\n",
> +				PTR_ERR(vlan));
> +			return;
> +		}
> +	}
> +
>  	fdb_entry = ice_eswitch_br_fdb_find(bridge, mac, vid);
>  	if (fdb_entry)
>  		ice_eswitch_br_fdb_entry_notify_and_cleanup(bridge, fdb_entry);
> @@ -329,7 +393,7 @@ ice_eswitch_br_fdb_entry_create(struct net_device *netdev,
>  	}
>  
>  	flow = ice_eswitch_br_flow_create(dev, hw, br_port->vsi_idx,
> -					  br_port->type, mac);
> +					  br_port->type, mac, vid);
>  	if (IS_ERR(flow)) {
>  		err = PTR_ERR(flow);
>  		goto err_add_flow;
> @@ -488,6 +552,207 @@ ice_eswitch_br_switchdev_event(struct notifier_block *nb,
>  	return NOTIFY_DONE;
>  }
>  
> +static void ice_eswitch_br_fdb_flush(struct ice_esw_br *bridge)
> +{
> +	struct ice_esw_br_fdb_entry *entry, *tmp;
> +
> +	list_for_each_entry_safe(entry, tmp, &bridge->fdb_list, list)
> +		ice_eswitch_br_fdb_entry_notify_and_cleanup(bridge, entry);
> +}
> +
> +static void
> +ice_eswitch_br_vlan_filtering_set(struct ice_esw_br *bridge, bool enable)
> +{
> +	if (enable == !!(bridge->flags & ICE_ESWITCH_BR_VLAN_FILTERING))
> +		return;
> +
> +	ice_eswitch_br_fdb_flush(bridge);
> +	if (enable)
> +		bridge->flags |= ICE_ESWITCH_BR_VLAN_FILTERING;
> +	else
> +		bridge->flags &= ~ICE_ESWITCH_BR_VLAN_FILTERING;
> +}
> +
> +static void
> +ice_eswitch_br_vlan_cleanup(struct ice_esw_br_port *port,
> +			    struct ice_esw_br_vlan *vlan)
> +{
> +	xa_erase(&port->vlans, vlan->vid);
> +	kfree(vlan);
> +}
> +
> +static void ice_eswitch_br_port_vlans_flush(struct ice_esw_br_port *port)
> +{
> +	struct ice_esw_br_vlan *vlan;
> +	unsigned long index;
> +
> +	xa_for_each(&port->vlans, index, vlan)
> +		ice_eswitch_br_vlan_cleanup(port, vlan);
> +}
> +
> +static struct ice_esw_br_vlan *
> +ice_eswitch_br_vlan_create(u16 vid, u16 flags, struct ice_esw_br_port *port)
> +{
> +	struct ice_esw_br_vlan *vlan;
> +	int err;
> +
> +	vlan = kzalloc(sizeof(*vlan), GFP_KERNEL);
> +	if (!vlan)
> +		return ERR_PTR(-ENOMEM);
> +
> +	vlan->vid = vid;
> +	vlan->flags = flags;
> +
> +	err = xa_insert(&port->vlans, vlan->vid, vlan, GFP_KERNEL);
> +	if (err) {
> +		kfree(vlan);
> +		return ERR_PTR(err);
> +	}
> +
> +	return vlan;
> +}
> +
> +static int
> +ice_eswitch_br_port_vlan_add(struct ice_esw_br *bridge, u16 vsi_idx, u16 vid,
> +			     u16 flags, struct netlink_ext_ack *extack)
> +{
> +	struct ice_esw_br_port *port;
> +	struct ice_esw_br_vlan *vlan;
> +
> +	port = xa_load(&bridge->ports, vsi_idx);
> +	if (!port)
> +		return -EINVAL;
> +
> +	vlan = xa_load(&port->vlans, vid);
> +	if (vlan) {
> +		if (vlan->flags == flags)
> +			return 0;
> +
> +		ice_eswitch_br_vlan_cleanup(port, vlan);
> +	}
> +
> +	vlan = ice_eswitch_br_vlan_create(vid, flags, port);
> +	if (IS_ERR(vlan)) {
> +		NL_SET_ERR_MSG_FMT_MOD(extack, "Failed to create VLAN entry, vid: %u, vsi: %u",
> +				       vid, vsi_idx);
> +		return PTR_ERR(vlan);
> +	}
> +
> +	return 0;
> +}
> +
> +static void
> +ice_eswitch_br_port_vlan_del(struct ice_esw_br *bridge, u16 vsi_idx, u16 vid)
> +{
> +	struct ice_esw_br_port *port;
> +	struct ice_esw_br_vlan *vlan;
> +
> +	port = xa_load(&bridge->ports, vsi_idx);
> +	if (!port)
> +		return;
> +
> +	vlan = xa_load(&port->vlans, vid);
> +	if (!vlan)
> +		return;
> +

Don't you also need to cleanup all FDBs on the port matching the vid
being deleted here?

> +	ice_eswitch_br_vlan_cleanup(port, vlan);
> +}
> +
> +static int
> +ice_eswitch_br_port_obj_add(struct net_device *netdev, const void *ctx,
> +			    const struct switchdev_obj *obj,
> +			    struct netlink_ext_ack *extack)
> +{
> +	struct ice_esw_br_port *br_port = ice_eswitch_br_netdev_to_port(netdev);
> +	struct switchdev_obj_port_vlan *vlan;
> +	int err;
> +
> +	if (!br_port)
> +		return -EINVAL;
> +
> +	switch (obj->id) {
> +	case SWITCHDEV_OBJ_ID_PORT_VLAN:
> +		vlan = SWITCHDEV_OBJ_PORT_VLAN(obj);
> +		err = ice_eswitch_br_port_vlan_add(br_port->bridge,
> +						   br_port->vsi_idx, vlan->vid,
> +						   vlan->flags, extack);
> +		return err;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int
> +ice_eswitch_br_port_obj_del(struct net_device *netdev, const void *ctx,
> +			    const struct switchdev_obj *obj)
> +{
> +	struct ice_esw_br_port *br_port = ice_eswitch_br_netdev_to_port(netdev);
> +	struct switchdev_obj_port_vlan *vlan;
> +
> +	if (!br_port)
> +		return -EINVAL;
> +
> +	switch (obj->id) {
> +	case SWITCHDEV_OBJ_ID_PORT_VLAN:
> +		vlan = SWITCHDEV_OBJ_PORT_VLAN(obj);
> +		ice_eswitch_br_port_vlan_del(br_port->bridge, br_port->vsi_idx,
> +					     vlan->vid);
> +		return 0;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int
> +ice_eswitch_br_port_obj_attr_set(struct net_device *netdev, const void *ctx,
> +				 const struct switchdev_attr *attr,
> +				 struct netlink_ext_ack *extack)
> +{
> +	struct ice_esw_br_port *br_port = ice_eswitch_br_netdev_to_port(netdev);
> +
> +	if (!br_port)
> +		return -EINVAL;
> +
> +	switch (attr->id) {
> +	case SWITCHDEV_ATTR_ID_BRIDGE_VLAN_FILTERING:
> +		ice_eswitch_br_vlan_filtering_set(br_port->bridge,
> +						  attr->u.vlan_filtering);
> +		return 0;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int
> +ice_eswitch_br_event_blocking(struct notifier_block *nb, unsigned long event,
> +			      void *ptr)
> +{
> +	struct net_device *dev = switchdev_notifier_info_to_dev(ptr);
> +	int err;
> +
> +	switch (event) {
> +	case SWITCHDEV_PORT_OBJ_ADD:
> +		err = switchdev_handle_port_obj_add(dev, ptr,
> +						    ice_eswitch_br_is_dev_valid,
> +						    ice_eswitch_br_port_obj_add);
> +		break;
> +	case SWITCHDEV_PORT_OBJ_DEL:
> +		err = switchdev_handle_port_obj_del(dev, ptr,
> +						    ice_eswitch_br_is_dev_valid,
> +						    ice_eswitch_br_port_obj_del);
> +		break;
> +	case SWITCHDEV_PORT_ATTR_SET:
> +		err = switchdev_handle_port_attr_set(dev, ptr,
> +						     ice_eswitch_br_is_dev_valid,
> +						     ice_eswitch_br_port_obj_attr_set);
> +		break;
> +	default:
> +		err = 0;
> +	}
> +
> +	return notifier_from_errno(err);
> +}
> +
>  static void
>  ice_eswitch_br_port_deinit(struct ice_esw_br *bridge,
>  			   struct ice_esw_br_port *br_port)
> @@ -506,6 +771,7 @@ ice_eswitch_br_port_deinit(struct ice_esw_br *bridge,
>  		vsi->vf->repr->br_port = NULL;
>  
>  	xa_erase(&bridge->ports, br_port->vsi_idx);
> +	ice_eswitch_br_port_vlans_flush(br_port);
>  	kfree(br_port);
>  }
>  
> @@ -518,6 +784,8 @@ ice_eswitch_br_port_init(struct ice_esw_br *bridge)
>  	if (!br_port)
>  		return ERR_PTR(-ENOMEM);
>  
> +	xa_init(&br_port->vlans);
> +
>  	br_port->bridge = bridge;
>  
>  	return br_port;
> @@ -817,6 +1085,7 @@ ice_eswitch_br_offloads_deinit(struct ice_pf *pf)
>  		return;
>  
>  	unregister_netdevice_notifier(&br_offloads->netdev_nb);
> +	unregister_switchdev_blocking_notifier(&br_offloads->switchdev_blk);
>  	unregister_switchdev_notifier(&br_offloads->switchdev_nb);
>  	destroy_workqueue(br_offloads->wq);
>  	/* Although notifier block is unregistered just before,
> @@ -860,6 +1129,15 @@ ice_eswitch_br_offloads_init(struct ice_pf *pf)
>  		goto err_reg_switchdev_nb;
>  	}
>  
> +	br_offloads->switchdev_blk.notifier_call =
> +		ice_eswitch_br_event_blocking;
> +	err = register_switchdev_blocking_notifier(&br_offloads->switchdev_blk);
> +	if (err) {
> +		dev_err(dev,
> +			"Failed to register bridge blocking switchdev notifier\n");
> +		goto err_reg_switchdev_blk;
> +	}
> +
>  	br_offloads->netdev_nb.notifier_call = ice_eswitch_br_port_event;
>  	err = register_netdevice_notifier(&br_offloads->netdev_nb);
>  	if (err) {
> @@ -871,6 +1149,8 @@ ice_eswitch_br_offloads_init(struct ice_pf *pf)
>  	return 0;
>  
>  err_reg_netdev_nb:
> +	unregister_switchdev_blocking_notifier(&br_offloads->switchdev_blk);
> +err_reg_switchdev_blk:
>  	unregister_switchdev_notifier(&br_offloads->switchdev_nb);
>  err_reg_switchdev_nb:
>  	destroy_workqueue(br_offloads->wq);
> diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch_br.h b/drivers/net/ethernet/intel/ice/ice_eswitch_br.h
> index 7afd00cdea9a..dd49b273451a 100644
> --- a/drivers/net/ethernet/intel/ice/ice_eswitch_br.h
> +++ b/drivers/net/ethernet/intel/ice/ice_eswitch_br.h
> @@ -42,6 +42,11 @@ struct ice_esw_br_port {
>  	struct ice_vsi *vsi;
>  	enum ice_esw_br_port_type type;
>  	u16 vsi_idx;
> +	struct xarray vlans;
> +};
> +
> +enum {
> +	ICE_ESWITCH_BR_VLAN_FILTERING = BIT(0),
>  };
>  
>  struct ice_esw_br {
> @@ -52,12 +57,14 @@ struct ice_esw_br {
>  	struct list_head fdb_list;
>  
>  	int ifindex;
> +	u32 flags;
>  };
>  
>  struct ice_esw_br_offloads {
>  	struct ice_pf *pf;
>  	struct ice_esw_br *bridge;
>  	struct notifier_block netdev_nb;
> +	struct notifier_block switchdev_blk;
>  	struct notifier_block switchdev_nb;
>  
>  	struct workqueue_struct *wq;
> @@ -71,6 +78,11 @@ struct ice_esw_br_fdb_work {
>  	unsigned long event;
>  };
>  
> +struct ice_esw_br_vlan {
> +	u16 vid;
> +	u16 flags;
> +};
> +
>  #define ice_nb_to_br_offloads(nb, nb_name) \
>  	container_of(nb, \
>  		     struct ice_esw_br_offloads, \
> @@ -81,6 +93,15 @@ struct ice_esw_br_fdb_work {
>  		     struct ice_esw_br_fdb_work, \
>  		     work)
>  
> +static inline bool ice_eswitch_br_is_vid_valid(u16 vid)
> +{
> +	/* In trunk VLAN mode, for untagged traffic the bridge sends requests
> +	 * to offload VLAN 1 with pvid and untagged flags set. Since these
> +	 * flags are not supported, add a MAC filter instead.
> +	 */
> +	return vid > 1;
> +}
> +
>  void
>  ice_eswitch_br_offloads_deinit(struct ice_pf *pf);
>  int


