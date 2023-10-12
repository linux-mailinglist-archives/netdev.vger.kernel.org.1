Return-Path: <netdev+bounces-40422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F98F7C74C7
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 19:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2A83282C48
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 17:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4A434CF7;
	Thu, 12 Oct 2023 17:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EdYN4GJ3"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F110266BE
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 17:29:58 +0000 (UTC)
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2563DED
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 10:29:56 -0700 (PDT)
Received: by mail-vk1-xa2a.google.com with SMTP id 71dfb90a1353d-49dc95be894so428188e0c.2
        for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 10:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697131795; x=1697736595; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ERpB4HRiq1DkWAntm2RqpcUmvZFIt5oY6QlWkecr8bs=;
        b=EdYN4GJ30lurxg3FXSI0WZiShtiN5Ylu5mY0VSS2mznVdP7lXMdTGJqT+EsIrQ6izt
         YgZ4OKuvFej+qkxCHSPe6MEm5QROq8XMFzKejfNb76onnRM0EglKedT3uUufxWBT7rSc
         fEfBUP2oDR/U3FNwbdbgGO4hV/PKOHuya2k3CyJfnAzOVgybMiInSW3ImH5CQ/pHa5vN
         GApA/VRlJ1PAXx0fbZQUxaVpb5T9ueWynd+ix0WBNa63thOYEn+pHPEOVFludpKL0RbM
         VieIZJ8NgktafFdmZJKATn92N/IEG99WLZr8byai2aedzRouBTgY8VSehbC0BgohQu7c
         crhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697131795; x=1697736595;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ERpB4HRiq1DkWAntm2RqpcUmvZFIt5oY6QlWkecr8bs=;
        b=Xs+PfjQMF2fFEYOvlIcbM3PoORhrfYiW8z61+9rwposQShHWPQ5J/sQf3BV+8p6Cen
         z0ZQkBQs0Q3CkVPFPD+2ROVH4Ju4jbshPsdyFJ3fVI4z1p2KZhRInnw4WxSdaJxhVmqh
         XWMgGG0IpX2xPY0FxyDjoQ53zJlzN8lzoXFO+0f8Csv00lJWef852dDPCLiFTBuwaoIY
         Q0lEPHjz0lazubJ8vnDEc6FM4sHxu9JfZofphxJOrmbWLS1EsrR+upP/0DQOzNqGVHd6
         IrF7TJ/nZdyV+v92YnxeLu1KWyBOEnNZbySQlUtG8ulg0N94i7if6+dMe+Z5NtFeM6fF
         8evQ==
X-Gm-Message-State: AOJu0YwrDwulIUPqiy4bRsCouOzr1V4OaMaVLGxw5mN/xGw/Fcc+vLch
	8lvTu5r4vtPtEWC4g4CgeiCHpVdlgRE=
X-Google-Smtp-Source: AGHT+IGIGmjCkbf2pu1fpLTthG5RUYcQX2PFfmVlRYaoNzGhsF+e4lF5DMzJNa0LBnZSbN6KfDxFeg==
X-Received: by 2002:a05:6122:2208:b0:48f:cd3a:108 with SMTP id bb8-20020a056122220800b0048fcd3a0108mr21697091vkb.12.1697131794685;
        Thu, 12 Oct 2023 10:29:54 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 10-20020ac5ce8a000000b0049a5b8d475csm3036049vke.34.2023.10.12.10.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 10:29:53 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 12 Oct 2023 10:29:51 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Konrad Knitter <konrad.knitter@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jdelvare@suse.com, Marcin Domagala <marcinx.domagala@intel.com>,
	Eric Joyner <eric.joyner@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-next v3] ice: read internal temperature sensor
Message-ID: <df0e5774-3db7-4f0f-a9e8-c4369c2e6083@roeck-us.net>
References: <20231012071358.1101438-1-konrad.knitter@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231012071358.1101438-1-konrad.knitter@intel.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 12, 2023 at 09:13:59AM +0200, Konrad Knitter wrote:
> Since 4.30 firmware exposes internal thermal sensor reading via admin
> queue commands. Expose those readouts via hwmon API when supported.
> 
> Driver provides current reading from HW as well as device specific
> thresholds for thermal alarm (Warning, Critical, Fatal) events.
> 
> $ sensors
> 
> Output
> =========================================================
> ice-pci-b100
> Adapter: PCI adapter
> temp1:        +62.0°C  (high = +95.0°C, crit = +105.0°C)
>                        (emerg = +115.0°C)
> 
> Co-developed-by: Marcin Domagala <marcinx.domagala@intel.com>
> Signed-off-by: Marcin Domagala <marcinx.domagala@intel.com>
> Co-developed-by: Eric Joyner <eric.joyner@intel.com>
> Signed-off-by: Eric Joyner <eric.joyner@intel.com>
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Konrad Knitter <konrad.knitter@intel.com>
> ---
> v3: add SPDX identification to ice_hwmon files
> v2: fix formmating issues, added hwmon maintainers to Cc
> ---
>  drivers/net/ethernet/intel/ice/Makefile       |   1 +

The code seems to be unconditional, but I see no added
dependency on CONFIG_HWMON. Does this compile if
HWMON=m and this code is built into the kernel, or if HWMON=n ?

>  drivers/net/ethernet/intel/ice/ice.h          |   1 +
>  .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  28 ++++
>  drivers/net/ethernet/intel/ice/ice_common.c   |  57 +++++++-
>  drivers/net/ethernet/intel/ice/ice_common.h   |   2 +
>  drivers/net/ethernet/intel/ice/ice_hwmon.c    | 130 ++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_hwmon.h    |  10 ++
>  drivers/net/ethernet/intel/ice/ice_main.c     |   5 +
>  drivers/net/ethernet/intel/ice/ice_type.h     |   4 +
>  9 files changed, 237 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_hwmon.c
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_hwmon.h
> 
> diff --git a/drivers/net/ethernet/intel/ice/Makefile b/drivers/net/ethernet/intel/ice/Makefile
> index 8757bec23fb3..b4c8f5303e57 100644
> --- a/drivers/net/ethernet/intel/ice/Makefile
> +++ b/drivers/net/ethernet/intel/ice/Makefile
> @@ -36,6 +36,7 @@ ice-y := ice_main.o	\
>  	 ice_repr.o	\
>  	 ice_tc_lib.o	\
>  	 ice_fwlog.o	\
> +	 ice_hwmon.o	\
>  	 ice_debugfs.o
>  ice-$(CONFIG_PCI_IOV) +=	\
>  	ice_sriov.o		\
> diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
> index ad5614d4449c..61d26be502b2 100644
> --- a/drivers/net/ethernet/intel/ice/ice.h
> +++ b/drivers/net/ethernet/intel/ice/ice.h
> @@ -650,6 +650,7 @@ struct ice_pf {
>  #define ICE_MAX_VF_AGG_NODES		32
>  	struct ice_agg_node vf_agg_node[ICE_MAX_VF_AGG_NODES];
>  	struct ice_dplls dplls;
> +	struct device *hwmon_dev;
>  };
>  
>  extern struct workqueue_struct *ice_lag_wq;
> diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
> index 1202abfb9eb3..3c4295f8e4ba 100644
> --- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
> +++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
> @@ -117,6 +117,7 @@ struct ice_aqc_list_caps_elem {
>  #define ICE_AQC_CAPS_NET_VER				0x004C
>  #define ICE_AQC_CAPS_PENDING_NET_VER			0x004D
>  #define ICE_AQC_CAPS_RDMA				0x0051
> +#define ICE_AQC_CAPS_SENSOR_READING			0x0067
>  #define ICE_AQC_CAPS_PCIE_RESET_AVOIDANCE		0x0076
>  #define ICE_AQC_CAPS_POST_UPDATE_RESET_RESTRICT		0x0077
>  #define ICE_AQC_CAPS_NVM_MGMT				0x0080
> @@ -1393,6 +1394,30 @@ struct ice_aqc_get_phy_rec_clk_out {
>  	__le16 node_handle;
>  };
>  
> +/* Get sensor reading (direct 0x0632) */
> +struct ice_aqc_get_sensor_reading {
> +	u8 sensor;
> +	u8 format;
> +	u8 reserved[6];
> +	__le32 addr_high;
> +	__le32 addr_low;
> +};
> +
> +/* Get sensor reading response (direct 0x0632) */
> +struct ice_aqc_get_sensor_reading_resp {
> +	union {
> +		u8 raw[8];
> +		/* Output data for sensor 0x00, format 0x00 */
> +		struct {
> +			s8 temp;
> +			u8 temp_warning_threshold;
> +			u8 temp_critical_threshold;
> +			u8 temp_fatal_threshold;
> +			u8 reserved[4];
> +		} s0f0;
> +	} data;
> +};

Kind of surprising that this doesn't need packed attributes.

> +
>  struct ice_aqc_link_topo_params {
>  	u8 lport_num;
>  	u8 lport_num_valid;
> @@ -2438,6 +2463,8 @@ struct ice_aq_desc {
>  		struct ice_aqc_restart_an restart_an;
>  		struct ice_aqc_set_phy_rec_clk_out set_phy_rec_clk_out;
>  		struct ice_aqc_get_phy_rec_clk_out get_phy_rec_clk_out;
> +		struct ice_aqc_get_sensor_reading get_sensor_reading;
> +		struct ice_aqc_get_sensor_reading_resp get_sensor_reading_resp;
>  		struct ice_aqc_gpio read_write_gpio;
>  		struct ice_aqc_sff_eeprom read_write_sff_param;
>  		struct ice_aqc_set_port_id_led set_port_id_led;
> @@ -2617,6 +2644,7 @@ enum ice_adminq_opc {
>  	ice_aqc_opc_set_mac_lb				= 0x0620,
>  	ice_aqc_opc_set_phy_rec_clk_out			= 0x0630,
>  	ice_aqc_opc_get_phy_rec_clk_out			= 0x0631,
> +	ice_aqc_opc_get_sensor_reading			= 0x0632,
>  	ice_aqc_opc_get_link_topo			= 0x06E0,
>  	ice_aqc_opc_read_i2c				= 0x06E2,
>  	ice_aqc_opc_write_i2c				= 0x06E3,
> diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
> index 283492314215..e566485a01b2 100644
> --- a/drivers/net/ethernet/intel/ice/ice_common.c
> +++ b/drivers/net/ethernet/intel/ice/ice_common.c
> @@ -2462,6 +2462,26 @@ ice_parse_fdir_dev_caps(struct ice_hw *hw, struct ice_hw_dev_caps *dev_p,
>  		  dev_p->num_flow_director_fltr);
>  }
>  
> +/**
> + * ice_parse_sensor_reading_cap - Parse ICE_AQC_CAPS_SENSOR_READING cap
> + * @hw: pointer to the HW struct
> + * @dev_p: pointer to device capabilities structure
> + * @cap: capability element to parse
> + *
> + * Parse ICE_AQC_CAPS_SENSOR_READING for device capability for reading
> + * enabled sensors.
> + */
> +static void
> +ice_parse_sensor_reading_cap(struct ice_hw *hw, struct ice_hw_dev_caps *dev_p,
> +			     struct ice_aqc_list_caps_elem *cap)
> +{
> +	dev_p->supported_sensors = le32_to_cpu(cap->number);
> +
> +	ice_debug(hw, ICE_DBG_INIT,
> +		  "dev caps: supported sensors (bitmap) = 0x%x\n",
> +		  dev_p->supported_sensors);
> +}
> +
>  /**
>   * ice_parse_dev_caps - Parse device capabilities
>   * @hw: pointer to the HW struct
> @@ -2507,9 +2527,12 @@ ice_parse_dev_caps(struct ice_hw *hw, struct ice_hw_dev_caps *dev_p,
>  		case ICE_AQC_CAPS_1588:
>  			ice_parse_1588_dev_caps(hw, dev_p, &cap_resp[i]);
>  			break;
> -		case  ICE_AQC_CAPS_FD:
> +		case ICE_AQC_CAPS_FD:
>  			ice_parse_fdir_dev_caps(hw, dev_p, &cap_resp[i]);
>  			break;
> +		case ICE_AQC_CAPS_SENSOR_READING:
> +			ice_parse_sensor_reading_cap(hw, dev_p, &cap_resp[i]);
> +			break;
>  		default:
>  			/* Don't list common capabilities as unknown */
>  			if (!found)
> @@ -5292,6 +5315,38 @@ ice_aq_get_phy_rec_clk_out(struct ice_hw *hw, u8 *phy_output, u8 *port_num,
>  	return status;
>  }
>  
> +/**
> + * ice_aq_get_sensor_reading
> + * @hw: pointer to the HW struct
> + * @sensor: sensor type
> + * @format: requested response format
> + * @data: pointer to data to be read from the sensor
> + *
> + * Get sensor reading (0x0632)
> + */
> +int ice_aq_get_sensor_reading(struct ice_hw *hw, u8 sensor, u8 format,
> +			      struct ice_aqc_get_sensor_reading_resp *data)

Are "sensor" and "format" ever going to be != 0 ? If not,
those parameters are just noise.

> +{
> +	struct ice_aqc_get_sensor_reading *cmd;
> +	struct ice_aq_desc desc;
> +	int status;
> +
> +	if (!data)
> +		return -EINVAL;

This is never called with a NULL pointer. The check is pointless.

> +
> +	ice_fill_dflt_direct_cmd_desc(&desc, ice_aqc_opc_get_sensor_reading);
> +	cmd = &desc.params.get_sensor_reading;
> +	cmd->sensor = sensor;
> +	cmd->format = format;
> +
> +	status = ice_aq_send_cmd(hw, &desc, NULL, 0, NULL);
> +	if (!status)
> +		memcpy(data, &desc.params.get_sensor_reading_resp,
> +		       sizeof(*data));
> +
> +	return status;
> +}
> +
>  /**
>   * ice_replay_pre_init - replay pre initialization
>   * @hw: pointer to the HW struct
> diff --git a/drivers/net/ethernet/intel/ice/ice_common.h b/drivers/net/ethernet/intel/ice/ice_common.h
> index 4a75c0c89301..e23787c17505 100644
> --- a/drivers/net/ethernet/intel/ice/ice_common.h
> +++ b/drivers/net/ethernet/intel/ice/ice_common.h
> @@ -240,6 +240,8 @@ ice_aq_set_phy_rec_clk_out(struct ice_hw *hw, u8 phy_output, bool enable,
>  int
>  ice_aq_get_phy_rec_clk_out(struct ice_hw *hw, u8 *phy_output, u8 *port_num,
>  			   u8 *flags, u16 *node_handle);
> +int ice_aq_get_sensor_reading(struct ice_hw *hw, u8 sensor, u8 format,
> +			      struct ice_aqc_get_sensor_reading_resp *data);
>  void
>  ice_stat_update40(struct ice_hw *hw, u32 reg, bool prev_stat_loaded,
>  		  u64 *prev_stat, u64 *cur_stat);
> diff --git a/drivers/net/ethernet/intel/ice/ice_hwmon.c b/drivers/net/ethernet/intel/ice/ice_hwmon.c
> new file mode 100644
> index 000000000000..6b23ae27169c
> --- /dev/null
> +++ b/drivers/net/ethernet/intel/ice/ice_hwmon.c
> @@ -0,0 +1,130 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (C) 2022, Intel Corporation. */
> +
> +#include "ice.h"
> +#include "ice_hwmon.h"
> +#include "ice_adminq_cmd.h"
> +
> +#include <linux/hwmon.h>
> +
> +#define ICE_INTERNAL_TEMP_SENSOR 0
> +#define ICE_INTERNAL_TEMP_SENSOR_FORMAT 0
> +

Personally I very much prefer

#define<space>NAME<tab>value

but obviously that is a maintainer decision to make.

> +#define TEMP_FROM_REG(reg) ((reg) * 1000)
> +
> +static const struct hwmon_channel_info *ice_hwmon_info[] = {
> +	HWMON_CHANNEL_INFO(temp,
> +			   HWMON_T_INPUT | HWMON_T_MAX |
> +			   HWMON_T_CRIT | HWMON_T_EMERGENCY),
> +	NULL
> +};
> +
> +static int ice_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
> +			  u32 attr, int channel, long *val)
> +{
> +	struct ice_aqc_get_sensor_reading_resp resp;
> +	struct ice_pf *pf = dev_get_drvdata(dev);
> +	int ret;
> +
> +	if (type != hwmon_temp)
> +		return -EOPNOTSUPP;
> +
> +	ret = ice_aq_get_sensor_reading(&pf->hw,
> +					ICE_INTERNAL_TEMP_SENSOR,
> +					ICE_INTERNAL_TEMP_SENSOR_FORMAT,
> +					&resp);
> +	if (ret) {
> +		dev_warn(dev, "%s HW read failure (%d)\n", __func__, ret);

Up to maintainers to decide, but I do not support error messages
as result of normal operation because it may end up clogging
the log if the underlying HW has a problem.

> +		return ret;
> +	}
> +
> +	switch (attr) {
> +	case hwmon_temp_input:
> +		*val = TEMP_FROM_REG(resp.data.s0f0.temp);
> +		break;
> +	case hwmon_temp_max:
> +		*val = TEMP_FROM_REG(resp.data.s0f0.temp_warning_threshold);
> +		break;
> +	case hwmon_temp_crit:
> +		*val = TEMP_FROM_REG(resp.data.s0f0.temp_critical_threshold);
> +		break;
> +	case hwmon_temp_emergency:
> +		*val = TEMP_FROM_REG(resp.data.s0f0.temp_fatal_threshold);
> +		break;
> +	default:
> +		dev_warn(dev, "%s unsupported attribute (%d)\n",
> +			 __func__, attr);

Same here, especially since this won't ever happen and the code
just exists to make the compiler happy.

> +		return -EINVAL;

Should be -EOPNOTSUPP.

> +	}
> +
> +	return 0;
> +}
> +
> +static umode_t ice_hwmon_is_visible(const void *data,
> +				    enum hwmon_sensor_types type, u32 attr,
> +				    int channel)
> +{
> +	if (type != hwmon_temp)
> +		return 0;
> +
> +	switch (attr) {
> +	case hwmon_temp_input:
> +	case hwmon_temp_crit:
> +	case hwmon_temp_max:
> +	case hwmon_temp_emergency:
> +		return 0444;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct hwmon_ops ice_hwmon_ops = {
> +	.is_visible = ice_hwmon_is_visible,
> +	.read = ice_hwmon_read
> +};
> +
> +static const struct hwmon_chip_info ice_chip_info = {
> +	.ops = &ice_hwmon_ops,
> +	.info = ice_hwmon_info
> +};
> +
> +static bool ice_is_internal_reading_supported(struct ice_pf *pf)
> +{
> +	if (pf->hw.pf_id)
> +		return false;
> +

This should be explained. From the rest of the code, it appears
that pf_id==0 reflects the first "pf". Why should this device not register
a hwmon device, and / or why is pf->hw.dev_caps.supported_sensors
unsupported or not set correctly for it ?

> +	unsigned long sensors = pf->hw.dev_caps.supported_sensors;
> +
> +	if (!_test_bit(ICE_SENSOR_SUPPORT_E810_INT_TEMP_BIT, &sensors))
> +		return false;
> +
> +	return true;

	return _test_bit(ICE_SENSOR_SUPPORT_E810_INT_TEMP_BIT, &sensors);

would do the same.

> +};
> +
> +void ice_hwmon_init(struct ice_pf *pf)
> +{
> +	struct device *dev = ice_pf_to_dev(pf);
> +	struct device *hdev;
> +
> +	if (!ice_is_internal_reading_supported(pf))
> +		return;
> +
> +	hdev = hwmon_device_register_with_info(dev, "ice", pf, &ice_chip_info,
> +					       NULL);
> +	if (IS_ERR(hdev)) {
> +		dev_warn(dev,
> +			 "hwmon_device_register_with_info returns error (%ld)",
> +			 PTR_ERR(hdev));
> +		return;
> +	}
> +	pf->hwmon_dev = hdev;
> +}
> +
> +void ice_hwmon_exit(struct ice_pf *pf)
> +{
> +	if (!ice_is_internal_reading_supported(pf))
> +		return;

In this case hwmon_dev would be NULL, making the above check unnecessary.

> +	if (!pf->hwmon_dev)
> +		return;
> +	hwmon_device_unregister(pf->hwmon_dev);
> +}
> diff --git a/drivers/net/ethernet/intel/ice/ice_hwmon.h b/drivers/net/ethernet/intel/ice/ice_hwmon.h
> new file mode 100644
> index 000000000000..8c74d19933d7
> --- /dev/null
> +++ b/drivers/net/ethernet/intel/ice/ice_hwmon.h
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (C) 2022, Intel Corporation. */
> +
> +#ifndef _ICE_HWMON_H_
> +#define _ICE_HWMON_H_
> +
> +void ice_hwmon_init(struct ice_pf *pf);
> +void ice_hwmon_exit(struct ice_pf *pf);
> +
> +#endif /* _ICE_HWMON_H_ */
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index afe19219a640..8f7e901a6c95 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -14,6 +14,7 @@
>  #include "ice_dcb_lib.h"
>  #include "ice_dcb_nl.h"
>  #include "ice_devlink.h"
> +#include "ice_hwmon.h"
>  /* Including ice_trace.h with CREATE_TRACE_POINTS defined will generate the
>   * ice tracepoint functions. This must be done exactly once across the
>   * ice driver.
> @@ -4785,6 +4786,8 @@ static void ice_init_features(struct ice_pf *pf)
>  
>  	if (ice_init_lag(pf))
>  		dev_warn(dev, "Failed to init link aggregation support\n");
> +
> +	ice_hwmon_init(pf);
>  }
>  
>  static void ice_deinit_features(struct ice_pf *pf)
> @@ -5310,6 +5313,8 @@ static void ice_remove(struct pci_dev *pdev)
>  		ice_free_vfs(pf);
>  	}
>  
> +	ice_hwmon_exit(pf);
> +
>  	ice_service_task_stop(pf);
>  	ice_aq_cancel_waiting_tasks(pf);
>  	set_bit(ICE_DOWN, pf->state);
> diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
> index 877a92099ef0..0b5425d33adf 100644
> --- a/drivers/net/ethernet/intel/ice/ice_type.h
> +++ b/drivers/net/ethernet/intel/ice/ice_type.h
> @@ -378,6 +378,8 @@ struct ice_hw_func_caps {
>  	struct ice_ts_func_info ts_func_info;
>  };
>  
> +#define ICE_SENSOR_SUPPORT_E810_INT_TEMP_BIT	0
> +
>  /* Device wide capabilities */
>  struct ice_hw_dev_caps {
>  	struct ice_hw_common_caps common_cap;
> @@ -386,6 +388,8 @@ struct ice_hw_dev_caps {
>  	u32 num_flow_director_fltr;	/* Number of FD filters available */
>  	struct ice_ts_dev_info ts_dev_info;
>  	u32 num_funcs;
> +	/* bitmap of supported sensors */
> +	u32 supported_sensors;
>  };
>  
>  /* MAC info */
> 
> base-commit: 2318d58f358e7aef726c038aff87a68bec8f09e0
> -- 
> 2.35.3
> 

