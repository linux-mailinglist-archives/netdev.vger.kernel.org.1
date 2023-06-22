Return-Path: <netdev+bounces-13044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B1373A07C
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 14:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59E12281969
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 12:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C811E51A;
	Thu, 22 Jun 2023 12:04:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC8E1B8FC
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 12:04:35 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D848B2694
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 05:04:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N7LHbWf4GermcYwJaKcMKUpq1v0SOUwbGM/dyGgMcNKF2Awf27uKgi5gosKeoR3HtotqGUocY0a/zaIjdXEuIHZlSbEDcFHp/cZaKkaRsvll1qPvsywyw/gPvHtmgjazQROxsK4P4F2Oux2cRVeSJ+MitF4vKjLpNrhwVxUB8eimTV5OXJgVouFCwJ2cMl0QwX8FTBMT6bOzbirkwt17mCzR2XcHjsW4qP8/x4xla5+kPbJOGsCoO7GCPAupd/j2DeGCHEU3+xTmh1gKErNolODKuHT2UVRF0ONYPYeba8FWhdY/O6t/csWtGnREIm+cCyftO0E0QMMa7lWGcFrPsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7lQp+AfHtjX+POzBI5olvWnr9VLh8xBZvdlCE/tKA9E=;
 b=mrKrFDPngXzYXKYoNsuAiDlgDxhepvXtoliag+R0xeaqpHfeKeaHULcsI0UAnp9GHU3s7bxTczp7dDwxcxtrNOzE8iiDWZEAOywaWjQRFWeFo4uo7wrN96yfBoflemToxTauh8qNJj/oh8V7tV8lhH0tumNcHCh3tHC6K/wjCC3P75I7BSDzwPvpt5uZi8ZPJ65C3Zk39G4pH8UGc18/DHidn2f0ekygoLs+a9+D8upkdHIjVR6FnFKPBHprJui3We7cA3ZDg+vBFKw9kTtbBNWRPvILpQeCwEPcoiI28AIX+2enboDIWb3UW6pCtwbLKlNXCZPLYNpJkjqddE+O1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7lQp+AfHtjX+POzBI5olvWnr9VLh8xBZvdlCE/tKA9E=;
 b=QPwi+FedviaN1WneOW/BFIEZQwfvYM70B+833LlmAR52cQv3ZYdjCvPnRWgtQFoE2bP5W8LEGbSdEbd35xXvsw0eYNc5zEDTsxHRBKTQCd+4o9j8uYivjAwIOB8Ro2HbhmFO39L3+SBZQxlp3SKgXj9BOY5ZGYZy7bQHxhKhXQUt+lqsR74sMV9pgmFRosyeZB1+L3nL5gRGbI3R+vHm39Js31RCS48nLccPRW/xos8JYU5vfPsrRBdwJIL45i2SFtBx4vLv9eGioI7qkngpeOTV7N7uVzxsZbuy5UUFwKaJGDw90CrC2J7ZCNZ+8LIyr2s9io9Yxr7ztcsOTN+MLA==
Received: from CY5PR15CA0005.namprd15.prod.outlook.com (2603:10b6:930:14::18)
 by PH7PR12MB8015.namprd12.prod.outlook.com (2603:10b6:510:26a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 12:03:39 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:930:14:cafe::d7) by CY5PR15CA0005.outlook.office365.com
 (2603:10b6:930:14::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 12:03:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.17 via Frontend Transport; Thu, 22 Jun 2023 12:03:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 22 Jun 2023
 05:03:29 -0700
Received: from fedora.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 22 Jun
 2023 05:03:25 -0700
References: <20230620174423.4144938-1-anthony.l.nguyen@intel.com>
 <20230620174423.4144938-8-anthony.l.nguyen@intel.com>
User-agent: mu4e 1.8.11; emacs 28.2
From: Vlad Buslov <vladbu@nvidia.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <netdev@vger.kernel.org>, Wojciech Drewek
	<wojciech.drewek@intel.com>, <jiri@resnulli.us>, <ivecera@redhat.com>,
	<simon.horman@corigine.com>, Sujai Buvaneswaran
	<sujai.buvaneswaran@intel.com>
Subject: Re: [PATCH net-next 07/12] ice: Switchdev FDB events support
Date: Thu, 22 Jun 2023 14:53:45 +0300
In-Reply-To: <20230620174423.4144938-8-anthony.l.nguyen@intel.com>
Message-ID: <87edm3vh4k.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|PH7PR12MB8015:EE_
X-MS-Office365-Filtering-Correlation-Id: ad71fb4b-3937-4a26-94c2-08db7318b756
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	g0fjYhQ9TtDjf2xLa2/MvnQdlmR4yTJWUmmh/8TG1xNYcgH6p88zkNU4s4I+56xdcIN8BH0KZOuUjXFOrYNZkXuiSoHXroIsARwAnfy3dkWZd9LCcroDI9CvDmpsh30Kio+iuy+B/ghKqB26faY6FrGce4AaGPtGvfewEUmpWrbyGXo0mEWMCKxaGtVJfrjLWhgw84sVZdUREGPueEJdZV5spV/xunE+6tDKHGCPNqcw00eUU+xaQj6xG14qyEZVOJXQVVLDj58iFflQa4PVPcvRl1EyONT1QL7yk59epLe07Mleit0Yx2VJ8dpQzZH+HKm5R/LANqPwd6QVymfvlbB7VMdt1E826uGTja5Hi67Vy+b5qYp3S2RS4+qmU+mAGLkWDkrDhaSyfpvSmGzHXKm9QyrVpKBxok/nU19xNUt9ZyDPby6/EgAmU/sWAj301e6YEYVSKD58nRMkX92XmcXIpK5ZJ/LL0o2czKx1bg7z1KYGBObIEdEwujqlUU1bBxOzpye/RQEkQM4jG1yltOwFEBnkPZl3EEjBZtjOuGTgNPt1yEOwaurHs7E4NJnoj7pY0JiPxYyUmNISb6e6+Be00tipo23J5NJbQYB2xCQoAvbG8/BLONOOq/Wh/qdRM1D4NInggarlooDhmsHUHqn1M39dENCz+JfgOz4GloHGYr3GR809iiuvGx1ZQnP8JdwvDJjVGZSQqgE3cwWAj+ltpxTZLrsvSxVx+QVJbDkMPlEbkJiWdRAMxuEKLPNC
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(396003)(346002)(451199021)(46966006)(40470700004)(36840700001)(54906003)(2616005)(86362001)(478600001)(40480700001)(7696005)(6666004)(16526019)(186003)(4326008)(41300700001)(66899021)(316002)(47076005)(83380400001)(6916009)(426003)(336012)(26005)(70206006)(70586007)(82310400005)(8676002)(8936002)(5660300002)(36756003)(7416002)(40460700003)(36860700001)(2906002)(30864003)(82740400003)(7636003)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 12:03:39.4277
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad71fb4b-3937-4a26-94c2-08db7318b756
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8015
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue 20 Jun 2023 at 10:44, Tony Nguyen <anthony.l.nguyen@intel.com> wrote:
> From: Wojciech Drewek <wojciech.drewek@intel.com>
>
> Listen for SWITCHDEV_FDB_{ADD|DEL}_TO_DEVICE events while in switchdev
> mode. Accept these events on both uplink and VF PR ports. Add HW
> rules in newly created workqueue. FDB entries are stored in rhashtable
> for lookup when removing the entry and in the list for cleanup
> purpose. Direction of the HW rule depends on the type of the ports
> on which the FDB event was received:
>
> ICE_ESWITCH_BR_UPLINK_PORT:
> TX rule that forwards the packet to the LAN (egress).
>
> ICE_ESWITCH_BR_VF_REPR_PORT:
> RX rule that forwards the packet to the VF associated
> with the port representor.

Just to clarify, does this implementation support offloading of VF-to-VF
traffic?

>
> In both cases the rule matches on the dst mac address.
> All the FDB entries are stored in the bridge structure.
> When the port is removed all the FDB entries associated with
> this port are removed as well. This is achieved thanks to the reference
> to the port that FDB entry holds.
>
> In the fwd rule we use only one lookup type (MAC address)
> but lkups_cnt variable is already introduced because
> we will have more lookups in the subsequent patches.
>
> Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_eswitch_br.c   | 439 +++++++++++++++++-
>  .../net/ethernet/intel/ice/ice_eswitch_br.h   |  46 ++
>  2 files changed, 484 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch_br.c b/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
> index 8b9ab68dfd53..8f22da490a69 100644
> --- a/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
> +++ b/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
> @@ -4,6 +4,14 @@
>  #include "ice.h"
>  #include "ice_eswitch_br.h"
>  #include "ice_repr.h"
> +#include "ice_switch.h"
> +
> +static const struct rhashtable_params ice_fdb_ht_params = {
> +	.key_offset = offsetof(struct ice_esw_br_fdb_entry, data),
> +	.key_len = sizeof(struct ice_esw_br_fdb_data),
> +	.head_offset = offsetof(struct ice_esw_br_fdb_entry, ht_node),
> +	.automatic_shrinking = true,
> +};
>  
>  static bool ice_eswitch_br_is_dev_valid(const struct net_device *dev)
>  {
> @@ -27,15 +35,412 @@ ice_eswitch_br_netdev_to_port(struct net_device *dev)
>  	return NULL;
>  }
>  
> +static void
> +ice_eswitch_br_ingress_rule_setup(struct ice_adv_rule_info *rule_info,
> +				  u8 pf_id, u16 vf_vsi_idx)
> +{
> +	rule_info->sw_act.vsi_handle = vf_vsi_idx;
> +	rule_info->sw_act.flag |= ICE_FLTR_RX;
> +	rule_info->sw_act.src = pf_id;
> +	rule_info->priority = 5;
> +}
> +
> +static void
> +ice_eswitch_br_egress_rule_setup(struct ice_adv_rule_info *rule_info,
> +				 u16 pf_vsi_idx)
> +{
> +	rule_info->sw_act.vsi_handle = pf_vsi_idx;
> +	rule_info->sw_act.flag |= ICE_FLTR_TX;
> +	rule_info->flags_info.act = ICE_SINGLE_ACT_LAN_ENABLE;
> +	rule_info->flags_info.act_valid = true;
> +	rule_info->priority = 5;
> +}
> +
> +static int
> +ice_eswitch_br_rule_delete(struct ice_hw *hw, struct ice_rule_query_data *rule)
> +{
> +	int err;
> +
> +	if (!rule)
> +		return -EINVAL;
> +
> +	err = ice_rem_adv_rule_by_id(hw, rule);
> +	kfree(rule);
> +
> +	return err;
> +}
> +
> +static struct ice_rule_query_data *
> +ice_eswitch_br_fwd_rule_create(struct ice_hw *hw, int vsi_idx, int port_type,
> +			       const unsigned char *mac)
> +{
> +	struct ice_adv_rule_info rule_info = { 0 };
> +	struct ice_rule_query_data *rule;
> +	struct ice_adv_lkup_elem *list;
> +	u16 lkups_cnt = 1;
> +	int err;
> +
> +	rule = kzalloc(sizeof(*rule), GFP_KERNEL);
> +	if (!rule)
> +		return ERR_PTR(-ENOMEM);
> +
> +	list = kcalloc(lkups_cnt, sizeof(*list), GFP_ATOMIC);
> +	if (!list) {
> +		err = -ENOMEM;
> +		goto err_list_alloc;
> +	}
> +
> +	switch (port_type) {
> +	case ICE_ESWITCH_BR_UPLINK_PORT:
> +		ice_eswitch_br_egress_rule_setup(&rule_info, vsi_idx);
> +		break;
> +	case ICE_ESWITCH_BR_VF_REPR_PORT:
> +		ice_eswitch_br_ingress_rule_setup(&rule_info, hw->pf_id,
> +						  vsi_idx);
> +		break;
> +	default:
> +		err = -EINVAL;
> +		goto err_add_rule;
> +	}
> +
> +	list[0].type = ICE_MAC_OFOS;
> +	ether_addr_copy(list[0].h_u.eth_hdr.dst_addr, mac);
> +	eth_broadcast_addr(list[0].m_u.eth_hdr.dst_addr);
> +
> +	rule_info.sw_act.fltr_act = ICE_FWD_TO_VSI;
> +
> +	err = ice_add_adv_rule(hw, list, lkups_cnt, &rule_info, rule);
> +	if (err)
> +		goto err_add_rule;
> +
> +	kfree(list);
> +
> +	return rule;
> +
> +err_add_rule:
> +	kfree(list);
> +err_list_alloc:
> +	kfree(rule);
> +
> +	return ERR_PTR(err);
> +}
> +
> +static struct ice_esw_br_flow *
> +ice_eswitch_br_flow_create(struct device *dev, struct ice_hw *hw, int vsi_idx,
> +			   int port_type, const unsigned char *mac)
> +{
> +	struct ice_rule_query_data *fwd_rule;
> +	struct ice_esw_br_flow *flow;
> +	int err;
> +
> +	flow = kzalloc(sizeof(*flow), GFP_KERNEL);
> +	if (!flow)
> +		return ERR_PTR(-ENOMEM);
> +
> +	fwd_rule = ice_eswitch_br_fwd_rule_create(hw, vsi_idx, port_type, mac);
> +	err = PTR_ERR_OR_ZERO(fwd_rule);
> +	if (err) {
> +		dev_err(dev, "Failed to create eswitch bridge %sgress forward rule, err: %d\n",
> +			port_type == ICE_ESWITCH_BR_UPLINK_PORT ? "e" : "in",
> +			err);
> +		goto err_fwd_rule;
> +	}
> +
> +	flow->fwd_rule = fwd_rule;
> +
> +	return flow;
> +
> +err_fwd_rule:
> +	kfree(flow);
> +
> +	return ERR_PTR(err);
> +}
> +
> +static struct ice_esw_br_fdb_entry *
> +ice_eswitch_br_fdb_find(struct ice_esw_br *bridge, const unsigned char *mac,
> +			u16 vid)
> +{
> +	struct ice_esw_br_fdb_data data = {
> +		.vid = vid,
> +	};
> +
> +	ether_addr_copy(data.addr, mac);
> +	return rhashtable_lookup_fast(&bridge->fdb_ht, &data,
> +				      ice_fdb_ht_params);
> +}
> +
> +static void
> +ice_eswitch_br_flow_delete(struct ice_pf *pf, struct ice_esw_br_flow *flow)
> +{
> +	struct device *dev = ice_pf_to_dev(pf);
> +	int err;
> +
> +	err = ice_eswitch_br_rule_delete(&pf->hw, flow->fwd_rule);
> +	if (err)
> +		dev_err(dev, "Failed to delete FDB forward rule, err: %d\n",
> +			err);
> +
> +	kfree(flow);
> +}
> +
> +static void
> +ice_eswitch_br_fdb_entry_delete(struct ice_esw_br *bridge,
> +				struct ice_esw_br_fdb_entry *fdb_entry)
> +{
> +	struct ice_pf *pf = bridge->br_offloads->pf;
> +
> +	rhashtable_remove_fast(&bridge->fdb_ht, &fdb_entry->ht_node,
> +			       ice_fdb_ht_params);
> +	list_del(&fdb_entry->list);
> +
> +	ice_eswitch_br_flow_delete(pf, fdb_entry->flow);
> +
> +	kfree(fdb_entry);
> +}
> +
> +static void
> +ice_eswitch_br_fdb_offload_notify(struct net_device *dev,
> +				  const unsigned char *mac, u16 vid,
> +				  unsigned long val)
> +{
> +	struct switchdev_notifier_fdb_info fdb_info = {
> +		.addr = mac,
> +		.vid = vid,
> +		.offloaded = true,
> +	};
> +
> +	call_switchdev_notifiers(val, dev, &fdb_info.info, NULL);
> +}
> +
> +static void
> +ice_eswitch_br_fdb_entry_notify_and_cleanup(struct ice_esw_br *bridge,
> +					    struct ice_esw_br_fdb_entry *entry)
> +{
> +	if (!(entry->flags & ICE_ESWITCH_BR_FDB_ADDED_BY_USER))
> +		ice_eswitch_br_fdb_offload_notify(entry->dev, entry->data.addr,
> +						  entry->data.vid,
> +						  SWITCHDEV_FDB_DEL_TO_BRIDGE);
> +	ice_eswitch_br_fdb_entry_delete(bridge, entry);
> +}
> +
> +static void
> +ice_eswitch_br_fdb_entry_find_and_delete(struct ice_esw_br *bridge,
> +					 const unsigned char *mac, u16 vid)
> +{
> +	struct ice_pf *pf = bridge->br_offloads->pf;
> +	struct ice_esw_br_fdb_entry *fdb_entry;
> +	struct device *dev = ice_pf_to_dev(pf);
> +
> +	fdb_entry = ice_eswitch_br_fdb_find(bridge, mac, vid);
> +	if (!fdb_entry) {
> +		dev_err(dev, "FDB entry with mac: %pM and vid: %u not found\n",
> +			mac, vid);
> +		return;
> +	}
> +
> +	ice_eswitch_br_fdb_entry_notify_and_cleanup(bridge, fdb_entry);
> +}
> +
> +static void
> +ice_eswitch_br_fdb_entry_create(struct net_device *netdev,
> +				struct ice_esw_br_port *br_port,
> +				bool added_by_user,
> +				const unsigned char *mac, u16 vid)
> +{
> +	struct ice_esw_br *bridge = br_port->bridge;
> +	struct ice_pf *pf = bridge->br_offloads->pf;
> +	struct device *dev = ice_pf_to_dev(pf);
> +	struct ice_esw_br_fdb_entry *fdb_entry;
> +	struct ice_esw_br_flow *flow;
> +	struct ice_hw *hw = &pf->hw;
> +	unsigned long event;
> +	int err;
> +
> +	fdb_entry = ice_eswitch_br_fdb_find(bridge, mac, vid);
> +	if (fdb_entry)
> +		ice_eswitch_br_fdb_entry_notify_and_cleanup(bridge, fdb_entry);
> +
> +	fdb_entry = kzalloc(sizeof(*fdb_entry), GFP_KERNEL);
> +	if (!fdb_entry) {
> +		err = -ENOMEM;
> +		goto err_exit;
> +	}
> +
> +	flow = ice_eswitch_br_flow_create(dev, hw, br_port->vsi_idx,
> +					  br_port->type, mac);
> +	if (IS_ERR(flow)) {
> +		err = PTR_ERR(flow);
> +		goto err_add_flow;
> +	}
> +
> +	ether_addr_copy(fdb_entry->data.addr, mac);
> +	fdb_entry->data.vid = vid;
> +	fdb_entry->br_port = br_port;
> +	fdb_entry->flow = flow;
> +	fdb_entry->dev = netdev;
> +	event = SWITCHDEV_FDB_ADD_TO_BRIDGE;
> +
> +	if (added_by_user) {
> +		fdb_entry->flags |= ICE_ESWITCH_BR_FDB_ADDED_BY_USER;
> +		event = SWITCHDEV_FDB_OFFLOADED;
> +	}
> +
> +	err = rhashtable_insert_fast(&bridge->fdb_ht, &fdb_entry->ht_node,
> +				     ice_fdb_ht_params);
> +	if (err)
> +		goto err_fdb_insert;
> +
> +	list_add(&fdb_entry->list, &bridge->fdb_list);
> +
> +	ice_eswitch_br_fdb_offload_notify(netdev, mac, vid, event);
> +
> +	return;
> +
> +err_fdb_insert:
> +	ice_eswitch_br_flow_delete(pf, flow);
> +err_add_flow:
> +	kfree(fdb_entry);
> +err_exit:
> +	dev_err(dev, "Failed to create fdb entry, err: %d\n", err);
> +}
> +
> +static void
> +ice_eswitch_br_fdb_work_dealloc(struct ice_esw_br_fdb_work *fdb_work)
> +{
> +	kfree(fdb_work->fdb_info.addr);
> +	kfree(fdb_work);
> +}
> +
> +static void
> +ice_eswitch_br_fdb_event_work(struct work_struct *work)
> +{
> +	struct ice_esw_br_fdb_work *fdb_work = ice_work_to_fdb_work(work);
> +	bool added_by_user = fdb_work->fdb_info.added_by_user;
> +	struct ice_esw_br_port *br_port = fdb_work->br_port;
> +	const unsigned char *mac = fdb_work->fdb_info.addr;
> +	u16 vid = fdb_work->fdb_info.vid;
> +
> +	rtnl_lock();
> +
> +	if (!br_port || !br_port->bridge)
> +		goto err_exit;
> +
> +	switch (fdb_work->event) {
> +	case SWITCHDEV_FDB_ADD_TO_DEVICE:
> +		ice_eswitch_br_fdb_entry_create(fdb_work->dev, br_port,
> +						added_by_user, mac, vid);
> +		break;
> +	case SWITCHDEV_FDB_DEL_TO_DEVICE:
> +		ice_eswitch_br_fdb_entry_find_and_delete(br_port->bridge,
> +							 mac, vid);
> +		break;
> +	default:
> +		goto err_exit;
> +	}
> +
> +err_exit:
> +	rtnl_unlock();
> +	dev_put(fdb_work->dev);
> +	ice_eswitch_br_fdb_work_dealloc(fdb_work);
> +}
> +
> +static struct ice_esw_br_fdb_work *
> +ice_eswitch_br_fdb_work_alloc(struct switchdev_notifier_fdb_info *fdb_info,
> +			      struct ice_esw_br_port *br_port,
> +			      struct net_device *dev,
> +			      unsigned long event)
> +{
> +	struct ice_esw_br_fdb_work *work;
> +	unsigned char *mac;
> +
> +	work = kzalloc(sizeof(*work), GFP_ATOMIC);
> +	if (!work)
> +		return ERR_PTR(-ENOMEM);
> +
> +	INIT_WORK(&work->work, ice_eswitch_br_fdb_event_work);
> +	memcpy(&work->fdb_info, fdb_info, sizeof(work->fdb_info));
> +
> +	mac = kzalloc(ETH_ALEN, GFP_ATOMIC);
> +	if (!mac) {
> +		kfree(work);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	ether_addr_copy(mac, fdb_info->addr);
> +	work->fdb_info.addr = mac;
> +	work->br_port = br_port;
> +	work->event = event;
> +	work->dev = dev;
> +
> +	return work;
> +}
> +
> +static int
> +ice_eswitch_br_switchdev_event(struct notifier_block *nb,
> +			       unsigned long event, void *ptr)
> +{
> +	struct net_device *dev = switchdev_notifier_info_to_dev(ptr);
> +	struct switchdev_notifier_fdb_info *fdb_info;
> +	struct switchdev_notifier_info *info = ptr;
> +	struct ice_esw_br_offloads *br_offloads;
> +	struct ice_esw_br_fdb_work *work;
> +	struct ice_esw_br_port *br_port;
> +	struct netlink_ext_ack *extack;
> +	struct net_device *upper;
> +
> +	br_offloads = ice_nb_to_br_offloads(nb, switchdev_nb);
> +	extack = switchdev_notifier_info_to_extack(ptr);
> +
> +	upper = netdev_master_upper_dev_get_rcu(dev);
> +	if (!upper)
> +		return NOTIFY_DONE;
> +
> +	if (!netif_is_bridge_master(upper))
> +		return NOTIFY_DONE;
> +
> +	if (!ice_eswitch_br_is_dev_valid(dev))
> +		return NOTIFY_DONE;
> +
> +	br_port = ice_eswitch_br_netdev_to_port(dev);
> +	if (!br_port)
> +		return NOTIFY_DONE;
> +
> +	switch (event) {
> +	case SWITCHDEV_FDB_ADD_TO_DEVICE:
> +	case SWITCHDEV_FDB_DEL_TO_DEVICE:
> +		fdb_info = container_of(info, typeof(*fdb_info), info);
> +
> +		work = ice_eswitch_br_fdb_work_alloc(fdb_info, br_port, dev,
> +						     event);
> +		if (IS_ERR(work)) {
> +			NL_SET_ERR_MSG_MOD(extack, "Failed to init switchdev fdb work");
> +			return notifier_from_errno(PTR_ERR(work));
> +		}
> +		dev_hold(dev);
> +
> +		queue_work(br_offloads->wq, &work->work);
> +		break;
> +	default:
> +		break;
> +	}
> +	return NOTIFY_DONE;
> +}
> +
>  static void
>  ice_eswitch_br_port_deinit(struct ice_esw_br *bridge,
>  			   struct ice_esw_br_port *br_port)
>  {
> +	struct ice_esw_br_fdb_entry *fdb_entry, *tmp;
>  	struct ice_vsi *vsi = br_port->vsi;
>  
> +	list_for_each_entry_safe(fdb_entry, tmp, &bridge->fdb_list, list) {
> +		if (br_port == fdb_entry->br_port)
> +			ice_eswitch_br_fdb_entry_delete(bridge, fdb_entry);
> +	}
> +
>  	if (br_port->type == ICE_ESWITCH_BR_UPLINK_PORT && vsi->back)
>  		vsi->back->br_port = NULL;
> -	else if (vsi->vf)
> +	else if (vsi->vf && vsi->vf->repr)

Shouldn't this check be in the previous patch? Don't see anything that
would influence this pointer assignment in this patch.

>  		vsi->vf->repr->br_port = NULL;
>  
>  	xa_erase(&bridge->ports, br_port->vsi_idx);
> @@ -129,6 +534,8 @@ ice_eswitch_br_deinit(struct ice_esw_br_offloads *br_offloads,
>  	ice_eswitch_br_ports_flush(bridge);
>  	WARN_ON(!xa_empty(&bridge->ports));
>  	xa_destroy(&bridge->ports);
> +	rhashtable_destroy(&bridge->fdb_ht);
> +
>  	br_offloads->bridge = NULL;
>  	kfree(bridge);
>  }
> @@ -137,11 +544,19 @@ static struct ice_esw_br *
>  ice_eswitch_br_init(struct ice_esw_br_offloads *br_offloads, int ifindex)
>  {
>  	struct ice_esw_br *bridge;
> +	int err;
>  
>  	bridge = kzalloc(sizeof(*bridge), GFP_KERNEL);
>  	if (!bridge)
>  		return ERR_PTR(-ENOMEM);
>  
> +	err = rhashtable_init(&bridge->fdb_ht, &ice_fdb_ht_params);
> +	if (err) {
> +		kfree(bridge);
> +		return ERR_PTR(err);
> +	}
> +
> +	INIT_LIST_HEAD(&bridge->fdb_list);
>  	bridge->br_offloads = br_offloads;
>  	bridge->ifindex = ifindex;
>  	xa_init(&bridge->ports);
> @@ -340,6 +755,8 @@ ice_eswitch_br_offloads_deinit(struct ice_pf *pf)
>  		return;
>  
>  	unregister_netdevice_notifier(&br_offloads->netdev_nb);
> +	unregister_switchdev_notifier(&br_offloads->switchdev_nb);
> +	destroy_workqueue(br_offloads->wq);
>  	/* Although notifier block is unregistered just before,
>  	 * so we don't get any new events, some events might be
>  	 * already in progress. Hold the rtnl lock and wait for
> @@ -365,6 +782,22 @@ ice_eswitch_br_offloads_init(struct ice_pf *pf)
>  		return PTR_ERR(br_offloads);
>  	}
>  
> +	br_offloads->wq = alloc_ordered_workqueue("ice_bridge_wq", 0);
> +	if (!br_offloads->wq) {
> +		err = -ENOMEM;
> +		dev_err(dev, "Failed to allocate bridge workqueue\n");
> +		goto err_alloc_wq;
> +	}
> +
> +	br_offloads->switchdev_nb.notifier_call =
> +		ice_eswitch_br_switchdev_event;
> +	err = register_switchdev_notifier(&br_offloads->switchdev_nb);
> +	if (err) {
> +		dev_err(dev,
> +			"Failed to register switchdev notifier\n");
> +		goto err_reg_switchdev_nb;
> +	}
> +
>  	br_offloads->netdev_nb.notifier_call = ice_eswitch_br_port_event;
>  	err = register_netdevice_notifier(&br_offloads->netdev_nb);
>  	if (err) {
> @@ -376,6 +809,10 @@ ice_eswitch_br_offloads_init(struct ice_pf *pf)
>  	return 0;
>  
>  err_reg_netdev_nb:
> +	unregister_switchdev_notifier(&br_offloads->switchdev_nb);
> +err_reg_switchdev_nb:
> +	destroy_workqueue(br_offloads->wq);
> +err_alloc_wq:
>  	rtnl_lock();
>  	ice_eswitch_br_offloads_dealloc(pf);
>  	rtnl_unlock();
> diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch_br.h b/drivers/net/ethernet/intel/ice/ice_eswitch_br.h
> index 3ad28a17298f..6fcacf545b98 100644
> --- a/drivers/net/ethernet/intel/ice/ice_eswitch_br.h
> +++ b/drivers/net/ethernet/intel/ice/ice_eswitch_br.h
> @@ -4,6 +4,33 @@
>  #ifndef _ICE_ESWITCH_BR_H_
>  #define _ICE_ESWITCH_BR_H_
>  
> +#include <linux/rhashtable.h>
> +
> +struct ice_esw_br_fdb_data {
> +	unsigned char addr[ETH_ALEN];
> +	u16 vid;
> +};
> +
> +struct ice_esw_br_flow {
> +	struct ice_rule_query_data *fwd_rule;
> +};
> +
> +enum {
> +	ICE_ESWITCH_BR_FDB_ADDED_BY_USER = BIT(0),
> +};
> +
> +struct ice_esw_br_fdb_entry {
> +	struct ice_esw_br_fdb_data data;
> +	struct rhash_head ht_node;
> +	struct list_head list;
> +
> +	int flags;
> +
> +	struct net_device *dev;
> +	struct ice_esw_br_port *br_port;
> +	struct ice_esw_br_flow *flow;
> +};
> +
>  enum ice_esw_br_port_type {
>  	ICE_ESWITCH_BR_UPLINK_PORT = 0,
>  	ICE_ESWITCH_BR_VF_REPR_PORT = 1,
> @@ -20,6 +47,9 @@ struct ice_esw_br {
>  	struct ice_esw_br_offloads *br_offloads;
>  	struct xarray ports;
>  
> +	struct rhashtable fdb_ht;
> +	struct list_head fdb_list;
> +
>  	int ifindex;
>  };
>  
> @@ -27,6 +57,17 @@ struct ice_esw_br_offloads {
>  	struct ice_pf *pf;
>  	struct ice_esw_br *bridge;
>  	struct notifier_block netdev_nb;
> +	struct notifier_block switchdev_nb;
> +
> +	struct workqueue_struct *wq;
> +};
> +
> +struct ice_esw_br_fdb_work {
> +	struct work_struct work;
> +	struct switchdev_notifier_fdb_info fdb_info;
> +	struct ice_esw_br_port *br_port;
> +	struct net_device *dev;
> +	unsigned long event;
>  };
>  
>  #define ice_nb_to_br_offloads(nb, nb_name) \
> @@ -34,6 +75,11 @@ struct ice_esw_br_offloads {
>  		     struct ice_esw_br_offloads, \
>  		     nb_name)
>  
> +#define ice_work_to_fdb_work(w) \
> +	container_of(w, \
> +		     struct ice_esw_br_fdb_work, \
> +		     work)
> +
>  void
>  ice_eswitch_br_offloads_deinit(struct ice_pf *pf);
>  int


