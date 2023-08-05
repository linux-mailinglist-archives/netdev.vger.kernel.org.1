Return-Path: <netdev+bounces-24681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C82677105B
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 17:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0B9B282326
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 15:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2387C2CC;
	Sat,  5 Aug 2023 15:35:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19C7A92A
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 15:35:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E8E8C433C8;
	Sat,  5 Aug 2023 15:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691249753;
	bh=hFlh1LwtL/3NBYjzNH57jm3fReT2tD1jvWjh/oZP4WA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c0WQ6kaU8mNGyAes6vdRLGbPpOHwteKi7XJk5jCV/sVunnxcfDC9T9Ylo5J2sNj7o
	 XBC8+pCAHHXWnAlN3jz3iaRNlvsoAuKBOo53ss1kH2yefdrg+75ebNjD2vGmaZWKIh
	 s7zKa335StY94KVnURXScU/8IrUGt4Sh4hsuvXo3gW3i7mYmxCtQG38JQgnid1TL7n
	 RXFC7f4Czf7Rc4x0ZcOeU3n7PIa7DLr/hm4mszsB5yfdTVxI8AJ/PfF6r7K2Mbq8bR
	 Uc6Vy8BrQoTPA0jD1MFRdSBoUQZQ1PYXwS6NwoB/FLcEWiztS4+L7sa9j3aW6tBmuK
	 Bp77XWXmbOvpA==
Date: Sat, 5 Aug 2023 17:35:49 +0200
From: Simon Horman <horms@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, jan.sokolowski@intel.com,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] i40e: Remove unused function declarations
Message-ID: <ZM5sVZdtAcxZ7Bof@vergenet.net>
References: <20230804125525.20244-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804125525.20244-1-yuehaibing@huawei.com>

On Fri, Aug 04, 2023 at 08:55:25PM +0800, Yue Haibing wrote:
> Commit f62b5060d670 ("i40e: fix mac address checking") left behind
> i40e_validate_mac_addr() declaration.
> Also the other declarations are declared but never implemented in
> commit 56a62fc86895 ("i40e: init code and hardware support").

Hi Yue Haibing,

It's not so important, but the last statement is not strictly true -
the named patch did implement i40e_validate_mac_addr()

If you do update the patch, I think it would be useful
to list "the other declarations" in the patch description.

> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

The comments above notwithstanding,

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  .../net/ethernet/intel/i40e/i40e_prototype.h    | 17 -----------------
>  1 file changed, 17 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_prototype.h b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
> index fe845987d99a..3eeee224f1fb 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_prototype.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
> @@ -18,7 +18,6 @@
>  /* adminq functions */
>  int i40e_init_adminq(struct i40e_hw *hw);
>  void i40e_shutdown_adminq(struct i40e_hw *hw);
> -void i40e_adminq_init_ring_data(struct i40e_hw *hw);
>  int i40e_clean_arq_element(struct i40e_hw *hw,
>  			   struct i40e_arq_event_info *e,
>  			   u16 *events_pending);
> @@ -51,7 +50,6 @@ i40e_asq_send_command_atomic_v2(struct i40e_hw *hw,
>  void i40e_debug_aq(struct i40e_hw *hw, enum i40e_debug_mask mask,
>  		   void *desc, void *buffer, u16 buf_len);
>  
> -void i40e_idle_aq(struct i40e_hw *hw);
>  bool i40e_check_asq_alive(struct i40e_hw *hw);
>  int i40e_aq_queue_shutdown(struct i40e_hw *hw, bool unloading);
>  const char *i40e_aq_str(struct i40e_hw *hw, enum i40e_admin_queue_err aq_err);
> @@ -117,9 +115,6 @@ int i40e_aq_set_link_restart_an(struct i40e_hw *hw,
>  int i40e_aq_get_link_info(struct i40e_hw *hw,
>  			  bool enable_lse, struct i40e_link_status *link,
>  			  struct i40e_asq_cmd_details *cmd_details);
> -int i40e_aq_set_local_advt_reg(struct i40e_hw *hw,
> -			       u64 advt_reg,
> -			       struct i40e_asq_cmd_details *cmd_details);
>  int i40e_aq_send_driver_version(struct i40e_hw *hw,
>  				struct i40e_driver_version *dv,
>  				struct i40e_asq_cmd_details *cmd_details);
> @@ -269,9 +264,6 @@ int i40e_aq_config_vsi_bw_limit(struct i40e_hw *hw,
>  				struct i40e_asq_cmd_details *cmd_details);
>  int i40e_aq_dcb_updated(struct i40e_hw *hw,
>  			struct i40e_asq_cmd_details *cmd_details);
> -int i40e_aq_config_switch_comp_bw_limit(struct i40e_hw *hw,
> -					u16 seid, u16 credit, u8 max_bw,
> -					struct i40e_asq_cmd_details *cmd_details);
>  int i40e_aq_config_vsi_tc_bw(struct i40e_hw *hw, u16 seid,
>  			     struct i40e_aqc_configure_vsi_tc_bw_data *bw_data,
>  			     struct i40e_asq_cmd_details *cmd_details);
> @@ -350,7 +342,6 @@ i40e_aq_configure_partition_bw(struct i40e_hw *hw,
>  int i40e_get_port_mac_addr(struct i40e_hw *hw, u8 *mac_addr);
>  int i40e_read_pba_string(struct i40e_hw *hw, u8 *pba_num,
>  			 u32 pba_num_size);
> -int i40e_validate_mac_addr(u8 *mac_addr);
>  void i40e_pre_tx_queue_cfg(struct i40e_hw *hw, u32 queue, bool enable);
>  /* prototype for functions used for NVM access */
>  int i40e_init_nvm(struct i40e_hw *hw);
> @@ -425,14 +416,6 @@ i40e_virtchnl_link_speed(enum i40e_aq_link_speed link_speed)
>  /* prototype for functions used for SW locks */
>  
>  /* i40e_common for VF drivers*/
> -void i40e_vf_parse_hw_config(struct i40e_hw *hw,
> -			     struct virtchnl_vf_resource *msg);
> -int i40e_vf_reset(struct i40e_hw *hw);
> -int i40e_aq_send_msg_to_pf(struct i40e_hw *hw,
> -			   enum virtchnl_ops v_opcode,
> -			   int v_retval,
> -			   u8 *msg, u16 msglen,
> -			   struct i40e_asq_cmd_details *cmd_details);
>  int i40e_set_filter_control(struct i40e_hw *hw,
>  			    struct i40e_filter_control_settings *settings);
>  int i40e_aq_add_rem_control_packet_filter(struct i40e_hw *hw,
> -- 
> 2.34.1
> 
> 

