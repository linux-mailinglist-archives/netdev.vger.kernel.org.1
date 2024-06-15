Return-Path: <netdev+bounces-103786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7589097EE
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 13:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 390E41C21074
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 11:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5441D38DCC;
	Sat, 15 Jun 2024 11:23:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAC92CCD0
	for <netdev@vger.kernel.org>; Sat, 15 Jun 2024 11:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718450584; cv=none; b=cqNcOhhE5k+ZUxhX3ioQKNmS15OkRYD/8M3cM8peXwOTFuZl0/xveXgLrKGWPrVCQgSWYPZMzm7NJrgsFIbYfAombASl/4yD9tiuYiyMBxlSwlikbtaS+4Y1wOCf6L8YgTbIPfguAd8AkcY0YhvKtQijlTaWENlH77CJoTuDqjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718450584; c=relaxed/simple;
	bh=ZCwDoM5xGqLn+Uvk6dIOfffa7uFUa1Lus1AAU0SsSn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Woii4XUylNr6yCNr2Mnn2Oc3IPXJE6HXENVl4x36WOfIcnfLpScBNh8An8kVPGiDP1HYqgUm4hEIz4yXxi0qtFj/Zk+4OCTwtc05s8lkrZB85VBRAJ8jdW0vmQhgwBBnFThUfO+elqy/PvofapfMknZHF0088z4DiYrIWMlm13I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sIRUU-0002hl-DH; Sat, 15 Jun 2024 13:22:38 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sIRUS-002UUt-71; Sat, 15 Jun 2024 13:22:36 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sIRUS-00CK51-0O;
	Sat, 15 Jun 2024 13:22:36 +0200
Date: Sat, 15 Jun 2024 13:22:36 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dent Project <dentproject@linuxfoundation.org>,
	kernel@pengutronix.de, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next v3 1/7] net: ethtool: pse-pd: Expand C33 PSE
 status with class, power and extended state
Message-ID: <Zm15fP1Sudot33H5@pengutronix.de>
References: <20240614-feature_poe_power_cap-v3-0-a26784e78311@bootlin.com>
 <20240614-feature_poe_power_cap-v3-1-a26784e78311@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240614-feature_poe_power_cap-v3-1-a26784e78311@bootlin.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hi Köry,

Overall, it looks good. Some fields need clarification, so don't be
surprised if I critique things I proposed myself. There are still
aspects I don't fully understand :)

On Fri, Jun 14, 2024 at 04:33:17PM +0200, Kory Maincent wrote:
> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

> +/**
> + * enum ethtool_c33_pse_ext_substate_class_num_events - class_num_events states
> + *      functions. IEEE 802.3-2022 33.2.4.4 Variables
> + *
> + * @ETHTOOL_C33_PSE_EXT_SUBSTATE_CLASS_NUM_EVENTS_CLASS_ERROR: Illegal class
> + *
> + * class_num_events is variable indicating the number of classification events
> + * performed by the PSE. A variable that is set in an implementation-dependent
> + * manner.
> + */
> +enum ethtool_c33_pse_ext_substate_class_num_events {
> +	ETHTOOL_C33_PSE_EXT_SUBSTATE_CLASS_NUM_EVENTS_CLASS_ERROR = 1,
> +};

I'm still not 100% sure by this name. class_num_events seems to be more
PSE side configuration variable. The pd692x0 0x43 value says "Illegal
class" without providing additional information. If I see it correctly,
typical classification will end with POWER_NOT_AVAILABLE if we will
detect not supported class. Something other should fail to detect an
illegal class.

According to 33.2.4.7
State diagrams we have CLASSIFICATION_EVAL function which evaluates
results of classification.
In case of class_num_events = 1, we have only tpdc_timer. In case of
error, will we get some timer related error?

In case of class_num_events = 2, if i see it correctly, PSE is doing
double classification and if results do not match, PSE will go to faul
state. See CLASS_EV2->(mr_pd_class_detected != temp_var) case.

Is it what we have here?

> +/**
> + * enum ethtool_c33_pse_ext_substate_error_condition - error_condition states
> + *      functions. IEEE 802.3-2022 33.2.4.4 Variables
> + *
> + * @ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_NON_EXISTING_PORT: Non-existing
> + *	port number
> + * @ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_UNDEFINED_PORT: Undefined port
> + * @ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_INTERNAL_HW_FAULT: Internal
> + *	hardware fault
> + * @ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_COMM_ERROR_AFTER_FORCE_ON:
> + *	Communication error after force on
> + * @ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_UNKNOWN_PORT_STATUS: Unknown
> + *	port status
> + * @ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_HOST_CRASH_TURN_OFF: Host
> + *	crash turn off
> + * @ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_HOST_CRASH_FORCE_SHUTDOWN:
> + *	Host crash force shutdown
> + * @ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_DETECTED_UNDERLOAD: Underload
> + *	state

pd692x0 documentation says, underload condition is related to Iport < Imin.
Sofar, I was not able to find Imin in the final IEEE 802.3 2022 spec.

There are some historical traces:
https://www.ieee802.org/3/af/public/mar01/darshan_3_0301.pdf

Instead, underload condition seems to be part of Maintain Power Signature (MPS)
monitoring. See 33.2.9 PSE power removal and 33.2.9.1.2 PSE DC MPS component
requirements.

Probably, it should go to the ETHTOOL_C33_PSE_EXT_SUBSTATE_MPS

> + * @ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_CONFIG_CHANGE: Configuration
> + *	change
> + * @ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_DETECTED_OVER_TEMP: Over
> + *	temperature detected
> + * @ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_CONNECTION_OPEN: Port is
> + *	not connected

This seems to reflect DETECT_EVAL->(signature = open_circuit) case. So,
it is probably not vendor specific error condition?

The difference between open and underload is probably:
- open: Iport = 0, detection state
- underload: Iport < Imin (or Ihold?), Iport can be 0. related to powered/MPS
  state.

> + *
> + * error_condition is a variable indicating the status of
> + * implementation-specific fault conditions or optionally other system faults
> + * that prevent the PSE from meeting the specifications in Table 33–11 and that
> + * require the PSE not to source power. These error conditions are different
> + * from those monitored by the state diagrams in Figure 33–10.
> + */
> +enum ethtool_c33_pse_ext_substate_error_condition {
> +	ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_NON_EXISTING_PORT = 1,
> +	ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_UNDEFINED_PORT,
> +	ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_INTERNAL_HW_FAULT,
> +	ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_COMM_ERROR_AFTER_FORCE_ON,
> +	ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_UNKNOWN_PORT_STATUS,
> +	ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_HOST_CRASH_TURN_OFF,
> +	ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_HOST_CRASH_FORCE_SHUTDOWN,
> +	ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_DETECTED_UNDERLOAD,
> +	ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_CONFIG_CHANGE,
> +	ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_DETECTED_OVER_TEMP,
> +	ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_CONNECTION_OPEN,
> +};
> +
> +/**
> + * enum ethtool_c33_pse_ext_substate_mr_pse_enable - mr_pse_enable states
> + *      functions. IEEE 802.3-2022 33.2.4.4 Variables
> + *
> + * @ETHTOOL_C33_PSE_EXT_SUBSTATE_MR_PSE_ENABLE_DISABLE_PIN_ACTIVE: Disable
> + *	pin active
> + *
> + * mr_pse_enable is control variable that selects PSE operation and test
> + * functions.
> + */
> +enum ethtool_c33_pse_ext_substate_mr_pse_enable {
> +	ETHTOOL_C33_PSE_EXT_SUBSTATE_MR_PSE_ENABLE_DISABLE_PIN_ACTIVE = 1,
> +};
> +
> +/**
> + * enum ethtool_c33_pse_ext_substate_option_detect_ted - option_detect_ted
> + *	states functions. IEEE 802.3-2022 33.2.4.4 Variables
> + *
> + * @ETHTOOL_C33_PSE_EXT_SUBSTATE_OPTION_DETECT_TED_DET_IN_PROCESS: Detection
> + *	in process
> + * @ETHTOOL_C33_PSE_EXT_SUBSTATE_OPTION_DETECT_TED_IMPROPER_CAP_DET: Improper
> + *	capacitor Detection
> + * @ETHTOOL_C33_PSE_EXT_SUBSTATE_OPTION_DETECT_TED_CONNECTION_CHECK_ERROR:
> + *	Connection check error
> + *
> + * option_detect_ted is a variable indicating if detection can be performed
> + * by the PSE during the ted_timer interval.
> + */
> +enum ethtool_c33_pse_ext_substate_option_detect_ted {
> +	ETHTOOL_C33_PSE_EXT_SUBSTATE_OPTION_DETECT_TED_DET_IN_PROCESS = 1,
> +	ETHTOOL_C33_PSE_EXT_SUBSTATE_OPTION_DETECT_TED_IMPROPER_CAP_DET,

The pd692x0 0x25 may be reported in two cases:
Fail due to out-of-range capacitor value or
Fail due to detected short value

On one side, this seems to be related to MONITOR_INRUSH function.
"33.2.7.5 Output current in POWER_UP mode

The PSE shall limit the maximum current sourced at the PI during
POWER_UP. The maximum inrush current sourced by the PSE shall not exceed the
PSE inrush template in Figure 33–13."

On other side, pd692x0 documentation is using 0x1C or 0x25 or 0xA7
values together with "INVALID SIG" description. In this case, this
values are related to signature detection stage, not power up or
tinrush_timer stage. In this case, i assume:
0x25 and 0xa7 refers to Table 33–6 or Table 145–8 Invalid PD detection signature
electrical characteristics.

Not sure about 0x1c - Non-802.3AF/AT powered device. Is it something
between Table 33–5 and Table 33–6? 

CCing UNGLinuxDriver@microchip.com

May be you will need to contact Microchip directly. Usually it helps :)

> +	ETHTOOL_C33_PSE_EXT_SUBSTATE_OPTION_DETECT_TED_CONNECTION_CHECK_ERROR,
> +};
> +
> +/**
> + * enum ethtool_c33_pse_ext_substate_option_vport_lim - option_vport_lim states
> + *      functions. IEEE 802.3-2022 33.2.4.4 Variables
> + *
> + * @ETHTOOL_C33_PSE_EXT_SUBSTATE_OPTION_VPORT_LIM_HIGH_VOLTAGE: Main supply
> + *	voltage is high
> + * @ETHTOOL_C33_PSE_EXT_SUBSTATE_OPTION_VPORT_LIM_LOW_VOLTAGE: Main supply
> + *	voltage is low
> + * @ETHTOOL_C33_PSE_EXT_SUBSTATE_OPTION_VPORT_LIM_VOLTAGE_INJECTION: Voltage
> + *	injection into the port
> + *
> + * option_vport_lim is an optional variable indicates if VPSE is out of the
> + * operating range during normal operating state.
> + */
> +enum ethtool_c33_pse_ext_substate_option_vport_lim {
> +	ETHTOOL_C33_PSE_EXT_SUBSTATE_OPTION_VPORT_LIM_HIGH_VOLTAGE = 1,
> +	ETHTOOL_C33_PSE_EXT_SUBSTATE_OPTION_VPORT_LIM_LOW_VOLTAGE,
> +	ETHTOOL_C33_PSE_EXT_SUBSTATE_OPTION_VPORT_LIM_VOLTAGE_INJECTION,
> +};
> +
> +/**
> + * enum ethtool_c33_pse_ext_substate_ovld_detected - ovld_detected states
> + *      functions. IEEE 802.3-2022 33.2.4.4 Variables
> + *
> + * @ETHTOOL_C33_PSE_EXT_SUBSTATE_OVLD_DETECTED_OVERLOAD: Overload state
> + *
> + * ovld_detected is a variable indicating if the PSE output current has been
> + * in an overload condition (see 33.2.7.6) for at least TCUT of a one-second
> + * sliding time.
> + */
> +enum ethtool_c33_pse_ext_substate_ovld_detected {
> +	ETHTOOL_C33_PSE_EXT_SUBSTATE_OVLD_DETECTED_OVERLOAD = 1,
> +};
> +
> +/**
> + * enum ethtool_c33_pse_ext_substate_pd_dll_power_type - pd_dll_power_type
> + *	states functions. IEEE 802.3-2022 33.2.4.4 Variables
> + *
> + * @ETHTOOL_C33_PSE_EXT_SUBSTATE_PD_DLL_POWER_TYPE_NON_802_3AF_AT_DEVICE:
> + *	Non-802.3AF/AT powered device
> + *
> + * pd_dll_power_type is a control variable initially output by the PSE power
> + * control state diagram (Figure 33–27), which can be updated by LLDP
> + * (see Table 33–26), that indicates the type of PD as advertised through
> + * Data Link Layer classification.
> + */
> +enum ethtool_c33_pse_ext_substate_pd_dll_power_type {
> +	ETHTOOL_C33_PSE_EXT_SUBSTATE_PD_DLL_POWER_TYPE_NON_802_3AF_AT_DEVICE = 1,
> +};

Here i was potentially wrong. LLDP stage is after power up, and this
values was probably set on early stage of signature detection. How can
we detect a device which is not conform to the 802.3AF/AT standard? Is
it something pre-802.3AF/AT, micorosemi specific vendor specific signature?

> +/**
> + * enum ethtool_c33_pse_ext_substate_power_not_available - power_not_available
> + *	states functions. IEEE 802.3-2022 33.2.4.4 Variables
> + *
> + * @ETHTOOL_C33_PSE_EXT_SUBSTATE_POWER_NOT_AVAILABLE_BUDGET_EXCEEDED: Power
> + *	budget exceeded
> + * @ETHTOOL_C33_PSE_EXT_SUBSTATE_POWER_NOT_AVAILABLE_PM_STATIC: Power
> + *	Management-Static

> + * @ETHTOOL_C33_PSE_EXT_SUBSTATE_POWER_NOT_AVAILABLE_PM_STATIC_OVL: Power
> + *	Management-Static-ovl

Here we need some comment updates. Here is my understanding, taken out
of thin air:
0x20 - We have per controller limit, but no limit per port is configured,
       in this case, if PD classification request more power then
       allowed by per controller budget, we will get this error.
       AllPortsPower + NewPortPower > ControllerMaxPower
0x3c - We have per port limit configured and it is over the controller
       budget.
       AllPortsMaxPower + NewPortMaxPower > ControllerMaxPower
0x3D - PD Class requesting more power that the Port configured port limit.
       PDClassPower > PortMaxPower

How about:
 * @ETHTOOL_C33_PSE_EXT_SUBSTATE_POWER_NOT_AVAILABLE_CONTROLLER_BUDGET_EXCEEDED: Power
 *   budget exceeded for the controller
 * @ETHTOOL_C33_PSE_EXT_SUBSTATE_POWER_NOT_AVAILABLE_PORT_POWER_LIMIT_EXCEEDS_CONTROLLER_BUDGET: Configured
 *   port power limit exceeded controller power budget
 * @ETHTOOL_C33_PSE_EXT_SUBSTATE_POWER_NOT_AVAILABLE_PD_REQUEST_EXCEEDS_PORT_LIMIT: Power
 *   request from PD exceeds port limit

> + * @ETHTOOL_C33_PSE_EXT_SUBSTATE_POWER_NOT_AVAILABLE_HW_PW_LIMIT: Power
> + * denied due to Hardware power limit

Not sure i understand this one correctly. Is it something like - all previous
errors can be solved by proper configuration, but on this one we can't do
anything. The HW is the limit. Correct? :)

> + * power_not_available is a variable that is asserted in an
> + * implementation-dependent manner when the PSE is no longer capable of
> + * sourcing sufficient power to support the attached PD. Sufficient power
> + * is defined by classification; see 33.2.6.
> + */
> +enum ethtool_c33_pse_ext_substate_power_not_available {
> +	ETHTOOL_C33_PSE_EXT_SUBSTATE_POWER_NOT_AVAILABLE_BUDGET_EXCEEDED =  1,
> +	ETHTOOL_C33_PSE_EXT_SUBSTATE_POWER_NOT_AVAILABLE_PM_STATIC,
> +	ETHTOOL_C33_PSE_EXT_SUBSTATE_POWER_NOT_AVAILABLE_PM_STATIC_OVL,
> +	ETHTOOL_C33_PSE_EXT_SUBSTATE_POWER_NOT_AVAILABLE_HW_PW_LIMIT,
> +};
> +
> +/**
> + * enum ethtool_c33_pse_ext_substate_short_detected - short_detected states
> + *      functions. IEEE 802.3-2022 33.2.4.4 Variables
> + *
> + * @ETHTOOL_C33_PSE_EXT_SUBSTATE_SHORT_DETECTED_SHORT_CONDITION: Short
> + *	condition was detected
> + *
> + * short_detected is a variable indicating if the PSE output current has been
> + * in a short circuit condition for TLIM within a sliding window (see 33.2.7.7).
> + */
> +enum ethtool_c33_pse_ext_substate_short_detected {
> +	ETHTOOL_C33_PSE_EXT_SUBSTATE_SHORT_DETECTED_SHORT_CONDITION = 1,
> +};
> +
>  /**
>   * enum ethtool_pse_types - Types of PSE controller.
>   * @ETHTOOL_PSE_UNKNOWN: Type of PSE controller is unknown
> diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
> index b49b804b9495..398a0aa8daad 100644
> --- a/include/uapi/linux/ethtool_netlink.h
> +++ b/include/uapi/linux/ethtool_netlink.h
> @@ -915,6 +915,10 @@ enum {
>  	ETHTOOL_A_C33_PSE_ADMIN_STATE,		/* u32 */
>  	ETHTOOL_A_C33_PSE_ADMIN_CONTROL,	/* u32 */
>  	ETHTOOL_A_C33_PSE_PW_D_STATUS,		/* u32 */
> +	ETHTOOL_A_C33_PSE_PW_CLASS,		/* u32 */
> +	ETHTOOL_A_C33_PSE_ACTUAL_PW,		/* u32 */
> +	ETHTOOL_A_C33_PSE_EXT_STATE,		/* u32 */
> +	ETHTOOL_A_C33_PSE_EXT_SUBSTATE,		/* u32 */
>  
>  	/* add new constants above here */
>  	__ETHTOOL_A_PSE_CNT,
> diff --git a/net/ethtool/pse-pd.c b/net/ethtool/pse-pd.c
> index 2c981d443f27..fec56db557d3 100644
> --- a/net/ethtool/pse-pd.c
> +++ b/net/ethtool/pse-pd.c
> @@ -86,7 +86,14 @@ static int pse_reply_size(const struct ethnl_req_info *req_base,
>  		len += nla_total_size(sizeof(u32)); /* _C33_PSE_ADMIN_STATE */
>  	if (st->c33_pw_status > 0)
>  		len += nla_total_size(sizeof(u32)); /* _C33_PSE_PW_D_STATUS */
> -
> +	if (st->c33_pw_class > 0)
> +		len += nla_total_size(sizeof(u32)); /* _C33_PSE_PW_CLASS */
> +	if (st->c33_actual_pw > 0)
> +		len += nla_total_size(sizeof(u32)); /* _C33_PSE_ACTUAL_PW */
> +	if (st->c33_ext_state_info.c33_pse_ext_state > 0)
> +		len += nla_total_size(sizeof(u32)); /* _C33_PSE_EXT_STATE */
> +	if (st->c33_ext_state_info.__c33_pse_ext_substate > 0)
> +		len += nla_total_size(sizeof(u32)); /* _C33_PSE_EXT_SUBSTATE */

Hm, we still may include __c33_pse_ext_substate even if c33_pse_ext_state == 0.

>  	return len;
>  }
>  
> @@ -117,6 +124,26 @@ static int pse_fill_reply(struct sk_buff *skb,
>  			st->c33_pw_status))
>  		return -EMSGSIZE;
>  
> +	if (st->c33_pw_class > 0 &&
> +	    nla_put_u32(skb, ETHTOOL_A_C33_PSE_PW_CLASS,
> +			st->c33_pw_class))
> +		return -EMSGSIZE;
> +
> +	if (st->c33_actual_pw > 0 &&
> +	    nla_put_u32(skb, ETHTOOL_A_C33_PSE_ACTUAL_PW,
> +			st->c33_actual_pw))
> +		return -EMSGSIZE;
> +
> +	if (st->c33_ext_state_info.c33_pse_ext_state > 0 &&
> +	    nla_put_u32(skb, ETHTOOL_A_C33_PSE_EXT_STATE,
> +			st->c33_ext_state_info.c33_pse_ext_state))
> +		return -EMSGSIZE;
> +
> +	if (st->c33_ext_state_info.__c33_pse_ext_substate > 0 &&
> +	    nla_put_u32(skb, ETHTOOL_A_C33_PSE_EXT_SUBSTATE,
> +			st->c33_ext_state_info.__c33_pse_ext_substate))
> +		return -EMSGSIZE;
> +

Same here. 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

