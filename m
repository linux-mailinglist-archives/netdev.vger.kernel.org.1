Return-Path: <netdev+bounces-13048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 266C373A090
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 14:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 499E51C210D6
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 12:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEFB1E513;
	Thu, 22 Jun 2023 12:11:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE4B15AE4
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 12:11:05 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0B9171C
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 05:11:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kCO85lHIlnGb4mObPO4EmIJfCQ/IJrwxO1qrYZIbMY6QdDMwZUXE0IHLa0BDHfZlUMN8Ur8u6del5EGn+WP+0adwnl+DxuxIXdwM2ABUUIqaDr5Ajx1O0f527DjaSMRRGrjrhGWjeR3zJMp82gKtoMjVtE9ie1mDh9X9Ydgrz3tDdTXtQ6GOnoANzLT4h8ReU5EvhTxB2l+DP7IcB+cuy8l5EI1axD/Pf2pttLjQp15/s7xDDI+kY/apeNsCdIGcsE0LmQV+JIRanOzqJXeJGxEsf0nURQ9F8mZ2w2MJ7pny82NouC5S4MABTh0LMsWBJj7G9pdXzlI7DnjTE/lUFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FYK+9q25jyez4mvXi4AazEroCquCx4PpSLxBGtvFGiI=;
 b=leSOfq1v9KWh1TilppxzF0vNd9SmZ5LqrHzDnwpyzoABoIZ0qDd6EnFappAduArM86aF1yTU9QvfnXAeCdj4Ws8kpVmbv3e0MBBNu1uMd5KG0kKlyVIw5Hyp9uumdGtSZT7ohvAzwhJ3xZWaCxIsXlEwg8GtaUjY6kXedvQgUiZ87uMWrA8HWKVbAH9tIOOO6TToXxxPWHKIU4iWt3C7ux7oP00b/CdYVIHOek4d7p9Smj4Qa4p35dGwaFD1r9IRrEDt89DcFXfZM244lXhdeNsTUkZRrOpkj7c+AwWQkACohdd2dHq2QBxZHKrM2D+2GZOG9oCnTZ9V2TtvQWYXIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FYK+9q25jyez4mvXi4AazEroCquCx4PpSLxBGtvFGiI=;
 b=fD/hX2ExroVx0QILxBSAjonZSq8pRRXIqb5cQM5qSzDMiNQ5vDNoo/YUGKopjdRXTKcO9BPn8GcGCNoC8/bazhkFIGDMlagLIz6LFXay6ykEK76m/C1yWpvzKS4ZXKJzLh6917UOFSI0G+wTWhfWn+T+Y6G2+1xqF3hvr5xinmyBtgceTVhb++WM3OIqyO6qXt7GuDoeZw3yFl+Dzo36xUuUaWGStsQhpqtpyh3H96rVFguXSmrS/olQifQAixf78Ihare68GaPsQNmh8R2cFzSSibowlYVGcCt9kr0k9JTBaExL3YxFk9aS96czsH8j1nlobk1b6xI8bWKzgJb/hQ==
Received: from BN9PR03CA0709.namprd03.prod.outlook.com (2603:10b6:408:ef::24)
 by DS0PR12MB8415.namprd12.prod.outlook.com (2603:10b6:8:fc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 12:10:59 +0000
Received: from BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ef:cafe::2) by BN9PR03CA0709.outlook.office365.com
 (2603:10b6:408:ef::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 12:10:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT073.mail.protection.outlook.com (10.13.177.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.41 via Frontend Transport; Thu, 22 Jun 2023 12:10:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 22 Jun 2023
 05:10:41 -0700
Received: from fedora.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 22 Jun
 2023 05:10:37 -0700
References: <20230620174423.4144938-1-anthony.l.nguyen@intel.com>
 <20230620174423.4144938-11-anthony.l.nguyen@intel.com>
User-agent: mu4e 1.8.11; emacs 28.2
From: Vlad Buslov <vladbu@nvidia.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <netdev@vger.kernel.org>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>, <jiri@resnulli.us>,
	<ivecera@redhat.com>, <simon.horman@corigine.com>, Wojciech Drewek
	<wojciech.drewek@intel.com>, Sujai Buvaneswaran
	<sujai.buvaneswaran@intel.com>
Subject: Re: [PATCH net-next 10/12] ice: implement bridge port vlan
Date: Thu, 22 Jun 2023 15:07:19 +0300
In-Reply-To: <20230620174423.4144938-11-anthony.l.nguyen@intel.com>
Message-ID: <875y7fvgsk.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT073:EE_|DS0PR12MB8415:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e0975b6-b4f5-4415-77fe-08db7319bd32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9MrL53FP7UmSWpBQrhdPraTOq6NhyfV8R9DHg4o27pojLSvu0rgXOsOrXjllNq9FmRYwCTz4n+QkGKxsduwPn1iU4PR7Pzvqfnmq3ywcowkKmql/1Wrf7vZT3W4fXOpvDeq11fEkfcClHo3d1NOWqmrxW5+VM5Gf5GuikYUo1GikJGNX0krXTT7tbM09KepBBhN9KofHD/NU0Nw0hK0iEOumJ/i6HH0UikW9M48BJ4hG5BpxNPCstPxeviBjB/lMv94Y/qy702vvWDrIF8PZqZUnPR51a46z5ht6UxwcV7cLMWwsUEHap7i0ijAI/dwItq0gIeP/LWBDF9NEnmbDLJXSP6XgdWe9HLVdfHl7h0KqNSR9geQ7Ddn0VJRd9YOFEKLfz9IdorBoREB0MpgjT0ctypmBVjHC4FelY61VaWyu0xK0qOJniJb/w76XCMqyo8hUVLJVzzvjrgTKxvXELGn61jPYOFBsW1O0JEtCe0v7aXb3M9WxfJi5ckYsypLSf0Y+43j9ackh6L143s9RsAQBN/FW0dRhSBw8Xi4zG/lxAjIsGg2KQ4TkiLQkFR8NueaB5xU2TxErI3za1i3CnFdH2lzMrRFu+fYWAC+NDMXdONvKcnI3RhNQQEfKc9Ss9K6LHy+Vhgdbg0pQjNLrWxwT+CMGl8zomL/OR+eHpYr7O49L4JM7TiJ+MX97KqUQzJiwb+SSEN3NqAf6MIyUDtE26jda0/Nqn617VntLJE6JzCS6j00hAroILSymJG8+
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(346002)(376002)(451199021)(46966006)(36840700001)(40470700004)(4326008)(40460700003)(2906002)(30864003)(316002)(82310400005)(478600001)(54906003)(7696005)(86362001)(82740400003)(7636003)(6666004)(356005)(41300700001)(36860700001)(426003)(83380400001)(6916009)(36756003)(336012)(70586007)(47076005)(2616005)(8676002)(8936002)(40480700001)(7416002)(16526019)(26005)(186003)(5660300002)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 12:10:58.6604
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e0975b6-b4f5-4415-77fe-08db7319bd32
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8415
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue 20 Jun 2023 at 10:44, Tony Nguyen <anthony.l.nguyen@intel.com> wrote:
> From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>
> Port VLAN in this case means push and pop VLAN action on specific vid.
> There are a few limitation in hardware:
> - push and pop can't be used separately
> - if port VLAN is used there can't be any trunk VLANs, because pop
>   action is done on all traffic received by VSI in port VLAN mode
> - port VLAN mode on uplink port isn't supported
>
> Reflect these limitations in code using dev_info to inform the user
> about unsupported configuration.
>
> In bridge mode there is a need to configure port vlan without resetting
> VFs. To do that implement ice_port_vlan_on/off() functions. They are
> only configuring correct vlan_ops to allow setting port vlan.
>
> We also need to clear port vlan without resetting the VF which is not
> supported right now. Change it by implementing clear_port_vlan ops.
> As previous VLAN configuration isn't always the same, store current
> config while creating port vlan and restore it in clear function.
>
> Configuration steps:
> - configure switchdev with bridge
> - #bridge vlan add dev eth0 vid 120 pvid untagged
> - #bridge vlan add dev eth1 vid 120 pvid untagged
> - ping from VF0 to VF1
>
> Reviewed-by: Simon Horman <simon.horman@corigine.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h          |   1 +
>  .../net/ethernet/intel/ice/ice_eswitch_br.c   |  90 ++++++++-
>  .../net/ethernet/intel/ice/ice_eswitch_br.h   |   1 +
>  .../ethernet/intel/ice/ice_vf_vsi_vlan_ops.c  | 186 ++++++++++--------
>  .../ethernet/intel/ice/ice_vf_vsi_vlan_ops.h  |   4 +
>  .../net/ethernet/intel/ice/ice_vsi_vlan_lib.c |  84 +++++++-
>  .../net/ethernet/intel/ice/ice_vsi_vlan_lib.h |   8 +
>  .../net/ethernet/intel/ice/ice_vsi_vlan_ops.h |   1 +
>  8 files changed, 285 insertions(+), 90 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
> index 8918a4b836a2..9109006336f0 100644
> --- a/drivers/net/ethernet/intel/ice/ice.h
> +++ b/drivers/net/ethernet/intel/ice/ice.h
> @@ -370,6 +370,7 @@ struct ice_vsi {
>  	u16 rx_buf_len;
>  
>  	struct ice_aqc_vsi_props info;	 /* VSI properties */
> +	struct ice_vsi_vlan_info vlan_info;	/* vlan config to be restored */
>  
>  	/* VSI stats */
>  	struct rtnl_link_stats64 net_stats;
> diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch_br.c b/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
> index 805a6b2fd965..d7e96241e8af 100644
> --- a/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
> +++ b/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
> @@ -5,6 +5,8 @@
>  #include "ice_eswitch_br.h"
>  #include "ice_repr.h"
>  #include "ice_switch.h"
> +#include "ice_vlan.h"
> +#include "ice_vf_vsi_vlan_ops.h"
>  
>  static const struct rhashtable_params ice_fdb_ht_params = {
>  	.key_offset = offsetof(struct ice_esw_br_fdb_entry, data),
> @@ -573,11 +575,27 @@ ice_eswitch_br_vlan_filtering_set(struct ice_esw_br *bridge, bool enable)
>  		bridge->flags &= ~ICE_ESWITCH_BR_VLAN_FILTERING;
>  }
>  
> +static void
> +ice_eswitch_br_clear_pvid(struct ice_esw_br_port *port)
> +{
> +	struct ice_vsi_vlan_ops *vlan_ops;
> +
> +	vlan_ops = ice_get_compat_vsi_vlan_ops(port->vsi);
> +
> +	vlan_ops->clear_port_vlan(port->vsi);
> +

vlan_ops->del_vlan() call seem to be missing here (dual to
vlan_ops->add_vlan() ice_eswitch_br_set_pvid()).

> +	ice_vf_vsi_disable_port_vlan(port->vsi);
> +
> +	port->pvid = 0;
> +}
> +
>  static void
>  ice_eswitch_br_vlan_cleanup(struct ice_esw_br_port *port,
>  			    struct ice_esw_br_vlan *vlan)
>  {
>  	xa_erase(&port->vlans, vlan->vid);
> +	if (port->pvid == vlan->vid)
> +		ice_eswitch_br_clear_pvid(port);
>  	kfree(vlan);
>  }
>  
> @@ -590,9 +608,50 @@ static void ice_eswitch_br_port_vlans_flush(struct ice_esw_br_port *port)
>  		ice_eswitch_br_vlan_cleanup(port, vlan);
>  }
>  
> +static int
> +ice_eswitch_br_set_pvid(struct ice_esw_br_port *port,
> +			struct ice_esw_br_vlan *vlan)
> +{
> +	struct ice_vlan port_vlan = ICE_VLAN(ETH_P_8021Q, vlan->vid, 0);
> +	struct device *dev = ice_pf_to_dev(port->vsi->back);
> +	struct ice_vsi_vlan_ops *vlan_ops;
> +	int err;
> +
> +	if (port->pvid == vlan->vid || vlan->vid == 1)
> +		return 0;
> +
> +	/* Setting port vlan on uplink isn't supported by hw */
> +	if (port->type == ICE_ESWITCH_BR_UPLINK_PORT)
> +		return -EOPNOTSUPP;
> +
> +	if (port->pvid) {
> +		dev_info(dev,
> +			 "Port VLAN (vsi=%u, vid=%u) already exists on the port, remove it before adding new one\n",
> +			 port->vsi_idx, port->pvid);
> +		return -EEXIST;
> +	}
> +
> +	ice_vf_vsi_enable_port_vlan(port->vsi);
> +
> +	vlan_ops = ice_get_compat_vsi_vlan_ops(port->vsi);
> +	err = vlan_ops->set_port_vlan(port->vsi, &port_vlan);
> +	if (err)
> +		return err;
> +
> +	err = vlan_ops->add_vlan(port->vsi, &port_vlan);
> +	if (err)
> +		return err;
> +
> +	ice_eswitch_br_port_vlans_flush(port);
> +	port->pvid = vlan->vid;
> +
> +	return 0;
> +}
> +
>  static struct ice_esw_br_vlan *
>  ice_eswitch_br_vlan_create(u16 vid, u16 flags, struct ice_esw_br_port *port)
>  {
> +	struct device *dev = ice_pf_to_dev(port->vsi->back);
>  	struct ice_esw_br_vlan *vlan;
>  	int err;
>  
> @@ -602,14 +661,30 @@ ice_eswitch_br_vlan_create(u16 vid, u16 flags, struct ice_esw_br_port *port)
>  
>  	vlan->vid = vid;
>  	vlan->flags = flags;
> +	if ((flags & BRIDGE_VLAN_INFO_PVID) &&
> +	    (flags & BRIDGE_VLAN_INFO_UNTAGGED)) {
> +		err = ice_eswitch_br_set_pvid(port, vlan);
> +		if (err)
> +			goto err_set_pvid;
> +	} else if ((flags & BRIDGE_VLAN_INFO_PVID) ||
> +		   (flags & BRIDGE_VLAN_INFO_UNTAGGED)) {
> +		dev_info(dev, "VLAN push and pop are supported only simultaneously\n");
> +		err = -EOPNOTSUPP;
> +		goto err_set_pvid;
> +	}
>  
>  	err = xa_insert(&port->vlans, vlan->vid, vlan, GFP_KERNEL);
> -	if (err) {
> -		kfree(vlan);
> -		return ERR_PTR(err);
> -	}
> +	if (err)
> +		goto err_insert;
>  
>  	return vlan;
> +
> +err_insert:
> +	if (port->pvid)
> +		ice_eswitch_br_clear_pvid(port);
> +err_set_pvid:
> +	kfree(vlan);
> +	return ERR_PTR(err);
>  }
>  
>  static int
> @@ -623,6 +698,13 @@ ice_eswitch_br_port_vlan_add(struct ice_esw_br *bridge, u16 vsi_idx, u16 vid,
>  	if (!port)
>  		return -EINVAL;
>  
> +	if (port->pvid) {
> +		dev_info(ice_pf_to_dev(port->vsi->back),
> +			 "Port VLAN (vsi=%u, vid=%d) exists on the port, remove it to add trunk VLANs\n",
> +			 port->vsi_idx, port->pvid);
> +		return -EEXIST;
> +	}
> +
>  	vlan = xa_load(&port->vlans, vid);
>  	if (vlan) {
>  		if (vlan->flags == flags)
> diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch_br.h b/drivers/net/ethernet/intel/ice/ice_eswitch_br.h
> index dd49b273451a..be4e6f096d55 100644
> --- a/drivers/net/ethernet/intel/ice/ice_eswitch_br.h
> +++ b/drivers/net/ethernet/intel/ice/ice_eswitch_br.h
> @@ -42,6 +42,7 @@ struct ice_esw_br_port {
>  	struct ice_vsi *vsi;
>  	enum ice_esw_br_port_type type;
>  	u16 vsi_idx;
> +	u16 pvid;
>  	struct xarray vlans;
>  };
>  
> diff --git a/drivers/net/ethernet/intel/ice/ice_vf_vsi_vlan_ops.c b/drivers/net/ethernet/intel/ice/ice_vf_vsi_vlan_ops.c
> index b1ffb81893d4..d7b10dc67f03 100644
> --- a/drivers/net/ethernet/intel/ice/ice_vf_vsi_vlan_ops.c
> +++ b/drivers/net/ethernet/intel/ice/ice_vf_vsi_vlan_ops.c
> @@ -21,6 +21,99 @@ noop_vlan(struct ice_vsi __always_unused *vsi)
>  	return 0;
>  }
>  
> +static void ice_port_vlan_on(struct ice_vsi *vsi)
> +{
> +	struct ice_vsi_vlan_ops *vlan_ops;
> +	struct ice_pf *pf = vsi->back;
> +
> +	if (ice_is_dvm_ena(&pf->hw)) {
> +		vlan_ops = &vsi->outer_vlan_ops;
> +
> +		/* setup outer VLAN ops */
> +		vlan_ops->set_port_vlan = ice_vsi_set_outer_port_vlan;
> +		vlan_ops->clear_port_vlan = ice_vsi_clear_outer_port_vlan;
> +		vlan_ops->clear_port_vlan = ice_vsi_clear_outer_port_vlan;
> +
> +		/* setup inner VLAN ops */
> +		vlan_ops = &vsi->inner_vlan_ops;
> +		vlan_ops->add_vlan = noop_vlan_arg;
> +		vlan_ops->del_vlan = noop_vlan_arg;
> +		vlan_ops->ena_stripping = ice_vsi_ena_inner_stripping;
> +		vlan_ops->dis_stripping = ice_vsi_dis_inner_stripping;
> +		vlan_ops->ena_insertion = ice_vsi_ena_inner_insertion;
> +		vlan_ops->dis_insertion = ice_vsi_dis_inner_insertion;
> +	} else {
> +		vlan_ops = &vsi->inner_vlan_ops;
> +
> +		vlan_ops->set_port_vlan = ice_vsi_set_inner_port_vlan;
> +		vlan_ops->clear_port_vlan = ice_vsi_clear_inner_port_vlan;
> +		vlan_ops->clear_port_vlan = ice_vsi_clear_inner_port_vlan;
> +	}
> +	vlan_ops->ena_rx_filtering = ice_vsi_ena_rx_vlan_filtering;
> +}
> +
> +static void ice_port_vlan_off(struct ice_vsi *vsi)
> +{
> +	struct ice_vsi_vlan_ops *vlan_ops;
> +	struct ice_pf *pf = vsi->back;
> +
> +	/* setup inner VLAN ops */
> +	vlan_ops = &vsi->inner_vlan_ops;
> +
> +	vlan_ops->ena_stripping = ice_vsi_ena_inner_stripping;
> +	vlan_ops->dis_stripping = ice_vsi_dis_inner_stripping;
> +	vlan_ops->ena_insertion = ice_vsi_ena_inner_insertion;
> +	vlan_ops->dis_insertion = ice_vsi_dis_inner_insertion;
> +
> +	if (ice_is_dvm_ena(&pf->hw)) {
> +		vlan_ops = &vsi->outer_vlan_ops;
> +
> +		vlan_ops->del_vlan = ice_vsi_del_vlan;
> +		vlan_ops->ena_stripping = ice_vsi_ena_outer_stripping;
> +		vlan_ops->dis_stripping = ice_vsi_dis_outer_stripping;
> +		vlan_ops->ena_insertion = ice_vsi_ena_outer_insertion;
> +		vlan_ops->dis_insertion = ice_vsi_dis_outer_insertion;
> +	} else {
> +		vlan_ops->del_vlan = ice_vsi_del_vlan;
> +	}
> +
> +	if (!test_bit(ICE_FLAG_VF_VLAN_PRUNING, pf->flags))
> +		vlan_ops->ena_rx_filtering = noop_vlan;
> +	else
> +		vlan_ops->ena_rx_filtering =
> +			ice_vsi_ena_rx_vlan_filtering;
> +}
> +
> +/**
> + * ice_vf_vsi_enable_port_vlan - Set VSI VLAN ops to support port VLAN
> + * @vsi: VF's VSI being configured
> + *
> + * The function won't create port VLAN, it only allows to create port VLAN
> + * using VLAN ops on the VF VSI.
> + */
> +void ice_vf_vsi_enable_port_vlan(struct ice_vsi *vsi)
> +{
> +	if (WARN_ON_ONCE(!vsi->vf))
> +		return;
> +
> +	ice_port_vlan_on(vsi);
> +}
> +
> +/**
> + * ice_vf_vsi_disable_port_vlan - Clear VSI support for creating port VLAN
> + * @vsi: VF's VSI being configured
> + *
> + * The function should be called after removing port VLAN on VSI
> + * (using VLAN ops)
> + */
> +void ice_vf_vsi_disable_port_vlan(struct ice_vsi *vsi)
> +{
> +	if (WARN_ON_ONCE(!vsi->vf))
> +		return;
> +
> +	ice_port_vlan_off(vsi);
> +}
> +
>  /**
>   * ice_vf_vsi_init_vlan_ops - Initialize default VSI VLAN ops for VF VSI
>   * @vsi: VF's VSI being configured
> @@ -39,91 +132,18 @@ void ice_vf_vsi_init_vlan_ops(struct ice_vsi *vsi)
>  	if (WARN_ON(!vf))
>  		return;
>  
> -	if (ice_is_dvm_ena(&pf->hw)) {
> -		vlan_ops = &vsi->outer_vlan_ops;
> +	if (ice_vf_is_port_vlan_ena(vf))
> +		ice_port_vlan_on(vsi);
> +	else
> +		ice_port_vlan_off(vsi);
>  
> -		/* outer VLAN ops regardless of port VLAN config */
> -		vlan_ops->add_vlan = ice_vsi_add_vlan;
> -		vlan_ops->ena_tx_filtering = ice_vsi_ena_tx_vlan_filtering;
> -		vlan_ops->dis_tx_filtering = ice_vsi_dis_tx_vlan_filtering;
> -
> -		if (ice_vf_is_port_vlan_ena(vf)) {
> -			/* setup outer VLAN ops */
> -			vlan_ops->set_port_vlan = ice_vsi_set_outer_port_vlan;
> -			/* all Rx traffic should be in the domain of the
> -			 * assigned port VLAN, so prevent disabling Rx VLAN
> -			 * filtering
> -			 */
> -			vlan_ops->dis_rx_filtering = noop_vlan;
> -			vlan_ops->ena_rx_filtering =
> -				ice_vsi_ena_rx_vlan_filtering;
> -
> -			/* setup inner VLAN ops */
> -			vlan_ops = &vsi->inner_vlan_ops;
> -			vlan_ops->add_vlan = noop_vlan_arg;
> -			vlan_ops->del_vlan = noop_vlan_arg;
> -			vlan_ops->ena_stripping = ice_vsi_ena_inner_stripping;
> -			vlan_ops->dis_stripping = ice_vsi_dis_inner_stripping;
> -			vlan_ops->ena_insertion = ice_vsi_ena_inner_insertion;
> -			vlan_ops->dis_insertion = ice_vsi_dis_inner_insertion;
> -		} else {
> -			vlan_ops->dis_rx_filtering =
> -				ice_vsi_dis_rx_vlan_filtering;
> -
> -			if (!test_bit(ICE_FLAG_VF_VLAN_PRUNING, pf->flags))
> -				vlan_ops->ena_rx_filtering = noop_vlan;
> -			else
> -				vlan_ops->ena_rx_filtering =
> -					ice_vsi_ena_rx_vlan_filtering;
> -
> -			vlan_ops->del_vlan = ice_vsi_del_vlan;
> -			vlan_ops->ena_stripping = ice_vsi_ena_outer_stripping;
> -			vlan_ops->dis_stripping = ice_vsi_dis_outer_stripping;
> -			vlan_ops->ena_insertion = ice_vsi_ena_outer_insertion;
> -			vlan_ops->dis_insertion = ice_vsi_dis_outer_insertion;
> -
> -			/* setup inner VLAN ops */
> -			vlan_ops = &vsi->inner_vlan_ops;
> -
> -			vlan_ops->ena_stripping = ice_vsi_ena_inner_stripping;
> -			vlan_ops->dis_stripping = ice_vsi_dis_inner_stripping;
> -			vlan_ops->ena_insertion = ice_vsi_ena_inner_insertion;
> -			vlan_ops->dis_insertion = ice_vsi_dis_inner_insertion;
> -		}
> -	} else {
> -		vlan_ops = &vsi->inner_vlan_ops;
> +	vlan_ops = ice_is_dvm_ena(&pf->hw) ?
> +		&vsi->outer_vlan_ops : &vsi->inner_vlan_ops;
>  
> -		/* inner VLAN ops regardless of port VLAN config */
> -		vlan_ops->add_vlan = ice_vsi_add_vlan;
> -		vlan_ops->dis_rx_filtering = ice_vsi_dis_rx_vlan_filtering;
> -		vlan_ops->ena_tx_filtering = ice_vsi_ena_tx_vlan_filtering;
> -		vlan_ops->dis_tx_filtering = ice_vsi_dis_tx_vlan_filtering;
> -
> -		if (ice_vf_is_port_vlan_ena(vf)) {
> -			vlan_ops->set_port_vlan = ice_vsi_set_inner_port_vlan;
> -			vlan_ops->ena_rx_filtering =
> -				ice_vsi_ena_rx_vlan_filtering;
> -			/* all Rx traffic should be in the domain of the
> -			 * assigned port VLAN, so prevent disabling Rx VLAN
> -			 * filtering
> -			 */
> -			vlan_ops->dis_rx_filtering = noop_vlan;
> -		} else {
> -			vlan_ops->dis_rx_filtering =
> -				ice_vsi_dis_rx_vlan_filtering;
> -			if (!test_bit(ICE_FLAG_VF_VLAN_PRUNING, pf->flags))
> -				vlan_ops->ena_rx_filtering = noop_vlan;
> -			else
> -				vlan_ops->ena_rx_filtering =
> -					ice_vsi_ena_rx_vlan_filtering;
> -
> -			vlan_ops->del_vlan = ice_vsi_del_vlan;
> -			vlan_ops->ena_stripping = ice_vsi_ena_inner_stripping;
> -			vlan_ops->dis_stripping = ice_vsi_dis_inner_stripping;
> -			vlan_ops->ena_insertion = ice_vsi_ena_inner_insertion;
> -			vlan_ops->dis_insertion = ice_vsi_dis_inner_insertion;
> -		}
> -	}
> +	vlan_ops->add_vlan = ice_vsi_add_vlan;
> +	vlan_ops->dis_rx_filtering = ice_vsi_dis_rx_vlan_filtering;
> +	vlan_ops->ena_tx_filtering = ice_vsi_ena_tx_vlan_filtering;
> +	vlan_ops->dis_tx_filtering = ice_vsi_dis_tx_vlan_filtering;
>  }
>  
>  /**
> diff --git a/drivers/net/ethernet/intel/ice/ice_vf_vsi_vlan_ops.h b/drivers/net/ethernet/intel/ice/ice_vf_vsi_vlan_ops.h
> index 875a4e615f39..df8aa09df3e3 100644
> --- a/drivers/net/ethernet/intel/ice/ice_vf_vsi_vlan_ops.h
> +++ b/drivers/net/ethernet/intel/ice/ice_vf_vsi_vlan_ops.h
> @@ -13,7 +13,11 @@ void ice_vf_vsi_cfg_svm_legacy_vlan_mode(struct ice_vsi *vsi);
>  
>  #ifdef CONFIG_PCI_IOV
>  void ice_vf_vsi_init_vlan_ops(struct ice_vsi *vsi);
> +void ice_vf_vsi_enable_port_vlan(struct ice_vsi *vsi);
> +void ice_vf_vsi_disable_port_vlan(struct ice_vsi *vsi);
>  #else
>  static inline void ice_vf_vsi_init_vlan_ops(struct ice_vsi *vsi) { }
> +static inline void ice_vf_vsi_enable_port_vlan(struct ice_vsi *vsi) { }
> +static inline void ice_vf_vsi_disable_port_vlan(struct ice_vsi *vsi) { }
>  #endif /* CONFIG_PCI_IOV */
>  #endif /* _ICE_PF_VSI_VLAN_OPS_H_ */
> diff --git a/drivers/net/ethernet/intel/ice/ice_vsi_vlan_lib.c b/drivers/net/ethernet/intel/ice/ice_vsi_vlan_lib.c
> index 5b4a0abb4607..76266e709a39 100644
> --- a/drivers/net/ethernet/intel/ice/ice_vsi_vlan_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_vsi_vlan_lib.c
> @@ -202,6 +202,24 @@ int ice_vsi_dis_inner_insertion(struct ice_vsi *vsi)
>  	return ice_vsi_manage_vlan_insertion(vsi);
>  }
>  
> +static void
> +ice_save_vlan_info(struct ice_aqc_vsi_props *info,
> +		   struct ice_vsi_vlan_info *vlan)
> +{
> +	vlan->sw_flags2 = info->sw_flags2;
> +	vlan->inner_vlan_flags = info->inner_vlan_flags;
> +	vlan->outer_vlan_flags = info->outer_vlan_flags;
> +}
> +
> +static void
> +ice_restore_vlan_info(struct ice_aqc_vsi_props *info,
> +		      struct ice_vsi_vlan_info *vlan)
> +{
> +	info->sw_flags2 = vlan->sw_flags2;
> +	info->inner_vlan_flags = vlan->inner_vlan_flags;
> +	info->outer_vlan_flags = vlan->outer_vlan_flags;
> +}
> +
>  /**
>   * __ice_vsi_set_inner_port_vlan - set port VLAN VSI context settings to enable a port VLAN
>   * @vsi: the VSI to update
> @@ -218,6 +236,7 @@ static int __ice_vsi_set_inner_port_vlan(struct ice_vsi *vsi, u16 pvid_info)
>  	if (!ctxt)
>  		return -ENOMEM;
>  
> +	ice_save_vlan_info(&vsi->info, &vsi->vlan_info);
>  	ctxt->info = vsi->info;
>  	info = &ctxt->info;
>  	info->inner_vlan_flags = ICE_AQ_VSI_INNER_VLAN_TX_MODE_ACCEPTUNTAGGED |
> @@ -259,6 +278,33 @@ int ice_vsi_set_inner_port_vlan(struct ice_vsi *vsi, struct ice_vlan *vlan)
>  	return __ice_vsi_set_inner_port_vlan(vsi, port_vlan_info);
>  }
>  
> +int ice_vsi_clear_inner_port_vlan(struct ice_vsi *vsi)
> +{
> +	struct ice_hw *hw = &vsi->back->hw;
> +	struct ice_aqc_vsi_props *info;
> +	struct ice_vsi_ctx *ctxt;
> +	int ret;
> +
> +	ctxt = kzalloc(sizeof(*ctxt), GFP_KERNEL);
> +	if (!ctxt)
> +		return -ENOMEM;
> +
> +	ice_restore_vlan_info(&vsi->info, &vsi->vlan_info);
> +	vsi->info.port_based_inner_vlan = 0;
> +	ctxt->info = vsi->info;
> +	info = &ctxt->info;
> +	info->valid_sections = cpu_to_le16(ICE_AQ_VSI_PROP_VLAN_VALID |
> +					   ICE_AQ_VSI_PROP_SW_VALID);
> +
> +	ret = ice_update_vsi(hw, vsi->idx, ctxt, NULL);
> +	if (ret)
> +		dev_err(ice_hw_to_dev(hw), "update VSI for port VLAN failed, err %d aq_err %s\n",
> +			ret, ice_aq_str(hw->adminq.sq_last_status));
> +
> +	kfree(ctxt);
> +	return ret;
> +}
> +
>  /**
>   * ice_cfg_vlan_pruning - enable or disable VLAN pruning on the VSI
>   * @vsi: VSI to enable or disable VLAN pruning on
> @@ -647,6 +693,7 @@ __ice_vsi_set_outer_port_vlan(struct ice_vsi *vsi, u16 vlan_info, u16 tpid)
>  	if (!ctxt)
>  		return -ENOMEM;
>  
> +	ice_save_vlan_info(&vsi->info, &vsi->vlan_info);
>  	ctxt->info = vsi->info;
>  
>  	ctxt->info.sw_flags2 |= ICE_AQ_VSI_SW_FLAG_RX_VLAN_PRUNE_ENA;
> @@ -689,9 +736,6 @@ __ice_vsi_set_outer_port_vlan(struct ice_vsi *vsi, u16 vlan_info, u16 tpid)
>   * used if DVM is supported. Also, this function should never be called directly
>   * as it should be part of ice_vsi_vlan_ops if it's needed.
>   *
> - * This function does not support clearing the port VLAN as there is currently
> - * no use case for this.
> - *
>   * Use the ice_vlan structure passed in to set this VSI in a port VLAN.
>   */
>  int ice_vsi_set_outer_port_vlan(struct ice_vsi *vsi, struct ice_vlan *vlan)
> @@ -705,3 +749,37 @@ int ice_vsi_set_outer_port_vlan(struct ice_vsi *vsi, struct ice_vlan *vlan)
>  
>  	return __ice_vsi_set_outer_port_vlan(vsi, port_vlan_info, vlan->tpid);
>  }
> +
> +/**
> + * ice_vsi_clear_outer_port_vlan - clear outer port vlan
> + * @vsi: VSI to configure
> + *
> + * The function is restoring previously set vlan config (saved in
> + * vsi->vlan_info). Setting happens in port vlan configuration.
> + */
> +int ice_vsi_clear_outer_port_vlan(struct ice_vsi *vsi)
> +{
> +	struct ice_hw *hw = &vsi->back->hw;
> +	struct ice_vsi_ctx *ctxt;
> +	int err;
> +
> +	ctxt = kzalloc(sizeof(*ctxt), GFP_KERNEL);
> +	if (!ctxt)
> +		return -ENOMEM;
> +
> +	ice_restore_vlan_info(&vsi->info, &vsi->vlan_info);
> +	vsi->info.port_based_outer_vlan = 0;
> +	ctxt->info = vsi->info;
> +
> +	ctxt->info.valid_sections =
> +		cpu_to_le16(ICE_AQ_VSI_PROP_OUTER_TAG_VALID |
> +			    ICE_AQ_VSI_PROP_SW_VALID);
> +
> +	err = ice_update_vsi(hw, vsi->idx, ctxt, NULL);
> +	if (err)
> +		dev_err(ice_pf_to_dev(vsi->back), "update VSI for clearing outer port based VLAN failed, err %d aq_err %s\n",
> +			err, ice_aq_str(hw->adminq.sq_last_status));
> +
> +	kfree(ctxt);
> +	return err;
> +}
> diff --git a/drivers/net/ethernet/intel/ice/ice_vsi_vlan_lib.h b/drivers/net/ethernet/intel/ice/ice_vsi_vlan_lib.h
> index f459909490ec..f0d84d11bd5b 100644
> --- a/drivers/net/ethernet/intel/ice/ice_vsi_vlan_lib.h
> +++ b/drivers/net/ethernet/intel/ice/ice_vsi_vlan_lib.h
> @@ -7,6 +7,12 @@
>  #include <linux/types.h>
>  #include "ice_vlan.h"
>  
> +struct ice_vsi_vlan_info {
> +	u8 sw_flags2;
> +	u8 inner_vlan_flags;
> +	u8 outer_vlan_flags;
> +};
> +
>  struct ice_vsi;
>  
>  int ice_vsi_add_vlan(struct ice_vsi *vsi, struct ice_vlan *vlan);
> @@ -17,6 +23,7 @@ int ice_vsi_dis_inner_stripping(struct ice_vsi *vsi);
>  int ice_vsi_ena_inner_insertion(struct ice_vsi *vsi, u16 tpid);
>  int ice_vsi_dis_inner_insertion(struct ice_vsi *vsi);
>  int ice_vsi_set_inner_port_vlan(struct ice_vsi *vsi, struct ice_vlan *vlan);
> +int ice_vsi_clear_inner_port_vlan(struct ice_vsi *vsi);
>  
>  int ice_vsi_ena_rx_vlan_filtering(struct ice_vsi *vsi);
>  int ice_vsi_dis_rx_vlan_filtering(struct ice_vsi *vsi);
> @@ -28,5 +35,6 @@ int ice_vsi_dis_outer_stripping(struct ice_vsi *vsi);
>  int ice_vsi_ena_outer_insertion(struct ice_vsi *vsi, u16 tpid);
>  int ice_vsi_dis_outer_insertion(struct ice_vsi *vsi);
>  int ice_vsi_set_outer_port_vlan(struct ice_vsi *vsi, struct ice_vlan *vlan);
> +int ice_vsi_clear_outer_port_vlan(struct ice_vsi *vsi);
>  
>  #endif /* _ICE_VSI_VLAN_LIB_H_ */
> diff --git a/drivers/net/ethernet/intel/ice/ice_vsi_vlan_ops.h b/drivers/net/ethernet/intel/ice/ice_vsi_vlan_ops.h
> index 5b47568f6256..b2d2330dedcb 100644
> --- a/drivers/net/ethernet/intel/ice/ice_vsi_vlan_ops.h
> +++ b/drivers/net/ethernet/intel/ice/ice_vsi_vlan_ops.h
> @@ -21,6 +21,7 @@ struct ice_vsi_vlan_ops {
>  	int (*ena_tx_filtering)(struct ice_vsi *vsi);
>  	int (*dis_tx_filtering)(struct ice_vsi *vsi);
>  	int (*set_port_vlan)(struct ice_vsi *vsi, struct ice_vlan *vlan);
> +	int (*clear_port_vlan)(struct ice_vsi *vsi);
>  };
>  
>  void ice_vsi_init_vlan_ops(struct ice_vsi *vsi);


