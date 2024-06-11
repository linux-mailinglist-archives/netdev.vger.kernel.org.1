Return-Path: <netdev+bounces-102499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E33C9034C8
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 10:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 183631C231E5
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 08:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC04172BCE;
	Tue, 11 Jun 2024 08:05:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D8A172BCB
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 08:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718093126; cv=none; b=kE6NqjKutfOr+EFCdJlVMmddOQMyLVygwfSEH6V3yv7RdyAEUfB7FlFhqpSXtvru0sXPoQe88UlAg8rK+FcksP2M6+YjkcU727MlEOp47Pvn48HIueUzEIsUjqwmFtAVL2vj9FJXSGdG3A1daUOiIr+48+7sV3XhoaI4lMIRKks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718093126; c=relaxed/simple;
	bh=/rJt/udw3YbvokwsNpUMuCAs8+ILQGffES8ZR7uMCDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jgN0FLHV+MgAslq+9OkyyXLkP2x2+3UQEjlY4vJcxEbLuWPF9VmbejU6vZ3oAcNjgZbpA3R/09I3PzfotRksF0koarQIWGz5v4MSuHnMeXXA8dFj7hqKZDUP18YHfb1CiCCm1DGBriLjB8/UEfLpd9xUG7F3YUm/JeQ5EZiSvtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sGwV6-0001tD-9Q; Tue, 11 Jun 2024 10:05:04 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sGwV4-001Urr-Ip; Tue, 11 Jun 2024 10:05:02 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sGwV4-004c1D-1Y;
	Tue, 11 Jun 2024 10:05:02 +0200
Date: Tue, 11 Jun 2024 10:05:02 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dent Project <dentproject@linuxfoundation.org>,
	kernel@pengutronix.de
Subject: Re: [PATCH net-next v2 2/8] net: ethtool: pse-pd: Expand C33 PSE
 status with class, power and extended state
Message-ID: <ZmgFLlWscicJmnxX@pengutronix.de>
References: <20240607-feature_poe_power_cap-v2-0-c03c2deb83ab@bootlin.com>
 <20240607-feature_poe_power_cap-v2-2-c03c2deb83ab@bootlin.com>
 <ZmaMGWMOvILHy8Iu@pengutronix.de>
 <20240610112559.57806b8c@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240610112559.57806b8c@kmaincent-XPS-13-7390>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Mon, Jun 10, 2024 at 11:25:59AM +0200, Kory Maincent wrote:
> Hello Oleksij,
> 
> On Mon, 10 Jun 2024 07:16:09 +0200
> Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> 
> > Hi Köry,
> > 
> > Thank you for your work.
> > 
> > On Fri, Jun 07, 2024 at 09:30:19AM +0200, Kory Maincent wrote:
> > > From: "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>  
> > 
> > ...
> > 
> > >  /**
> > > diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
> > > index 8733a3117902..ef65ad4612d2 100644
> > > --- a/include/uapi/linux/ethtool.h
> > > +++ b/include/uapi/linux/ethtool.h
> > > @@ -752,6 +752,47 @@ enum ethtool_module_power_mode {
> > >  	ETHTOOL_MODULE_POWER_MODE_HIGH,
> > >  };
> > >  
> > > +/* C33 PSE extended state */
> > > +enum ethtool_c33_pse_ext_state {
> > > +	ETHTOOL_C33_PSE_EXT_STATE_UNKNOWN = 1,  
> > 
> > I assume, In case the state is unknown, better to set it to 0 and not
> > report it to the user space in the first place. Do we really need it?
> 
> The pd692x0 report this for the unknown state: "Port is not mapped to physical
> port, port is in unknown state, or PD692x0 fails to communicate with PD69208
> device allocated for this port."
> Also it has a status for open port (not connected) state.
> (ETHTOOL_C33_PSE_EXT_SUBSTATE_V_OPEN)
> Do you prefer to use the same error for both state?
>  
> > > +	ETHTOOL_C33_PSE_EXT_STATE_DETECTION,
> > > +	ETHTOOL_C33_PSE_EXT_STATE_CLASSIFICATION_FAILURE,
> > > +	ETHTOOL_C33_PSE_EXT_STATE_HARDWARE_ISSUE,
> > > +	ETHTOOL_C33_PSE_EXT_STATE_VOLTAGE_ISSUE,
> > > +	ETHTOOL_C33_PSE_EXT_STATE_CURRENT_ISSUE,
> > > +	ETHTOOL_C33_PSE_EXT_STATE_POWER_BUDGET_EXCEEDED,  
> > 
> > What is the difference between POWER_BUDGET_EXCEEDED and
> > STATE_CURRENT_ISSUE->CRT_OVERLOAD? If there is some difference, it
> > should be commented.
> 
> Current overload seems to be describing the "Overload current detection range
> (Icut)" As described in the IEEE standard.
> Not sure If budget exceeded should use the same error.
> 
> > Please provide comments describing how all of this states and substates
> > should be used.
> 
> The enum errors I wrote is a bit subjective and are taken from the PD692x0
> port status list. Go ahead to purpose any change, I have tried to make
> categories that make sense but I might have made wrong choice.

Here is my proposal aligned with IEEE 802.3-2022 33.2.4.4:

/**                                                                                  
 * enum ethtool_c33_pse_ext_state - groups of PSE extended states                    
 *      functions. IEEE 802.3-2022 33.2.4.4 Variables                                
 *                                                                                  
 * @ETHTOOL_C33_PSE_EXT_STATE_ERROR_CONDITION: Group of error_condition states       
 * @ETHTOOL_C33_PSE_EXT_STATE_MR_PSE_ENABLE: Group of mr_pse_enable states              
 * @ETHTOOL_C33_PSE_EXT_STATE_OPTION_VPORT_LIM: Group of option_vport_lim states          
 * @ETHTOOL_C33_PSE_EXT_STATE_OVLD_DETECTED: Group of ovld_detected states       
 * @ETHTOOL_C33_PSE_EXT_STATE_PD_DLL_POWER_TYPE: Group of pd_dll_power_type states   
 * @ETHTOOL_C33_PSE_EXT_STATE_POWER_NOT_AVAILABLE: Group of power_not_available states
 * @ETHTOOL_C33_PSE_EXT_STATE_SHORT_DETECTED: Group of short_detected states         
 * @ETHTOOL_C33_PSE_EXT_STATE_TINRUSH_TIMER: Group of tinrush_timer states            
 */ 
enum ethtool_c33_pse_ext_state {
    ETHTOOL_C33_PSE_EXT_STATE_ERROR_CONDITION,
    ETHTOOL_C33_PSE_EXT_STATE_MR_PSE_ENABLE,
    ETHTOOL_C33_PSE_EXT_STATE_OPTION_VPORT_LIM,
    ETHTOOL_C33_PSE_EXT_STATE_OVLD_DETECTED,
    ETHTOOL_C33_PSE_EXT_STATE_PD_DLL_POWER_TYPE,
    ETHTOOL_C33_PSE_EXT_STATE_POWER_NOT_AVAILABLE,
    ETHTOOL_C33_PSE_EXT_STATE_SHORT_DETECTED,
    ETHTOOL_C33_PSE_EXT_STATE_TINRUSH_TIMER,
};

/**                                                                                  
 * enum ethtool_c33_pse_ext_substate_error_condition - error_condition states        
 *      functions. IEEE 802.3-2022 33.2.4.4 Variables                                
 *                                                                                  
 * @ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_NON_EXISTING_PORT: Non-existing port number (PD692x0 0x0C)                  
 *      "Port is off: Non-existing port number. Fewer ports are available than the maximum number of ports that the Controller can support. Unavailable ports are considered 'off'. Currently not used."
 * @ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_UNDEFINED_PORT: Undefined port (PD692x0 0x11)                                
 *      "Port is yet undefined. Port is not mapped to physical port or port is in unknown state or PD69200 failed to communicate with PD69208 device allocated for this port."
 * @ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_INTERNAL_HW_FAULT: Internal hardware fault (PD692x0 0x12)                   
 *      "Port is off: Internal hardware fault. Port does not respond. Hardware fault, system initialization or PD69200 lost communication with PD69208 device allocated for this port. (Part of refresh function)."
 * @ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_INTERNAL_HW_FAULT_2: Internal hardware fault (PD692x0 0x21)                 
 *      "Port is off: Internal hardware fault. Hardware problems preventing port operation. Currently not used. Used for 4P mapping with PD39208 device."
 * @ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_COMM_ERROR_AFTER_FORCE_ON: Communication error after force on (PD692x0 0x33) 
 *      "Port is off: Communication error with PoE devices after Force On. This error appears only after port is forced on."
 * @ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_UNKNOWN_PORT_STATUS: Unknown port status (PD692x0 0x37)                     
 *      "Port is off: Unknown device port status. The device returns an unknown port status for the software. Currently not used."
 * @ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_HOST_CRASH_TURN_OFF: Host crash turn off (PD692x0 0x44)                     
 *      "Port is off: Turn off during host crash. Port is off - After host crash the port is off and waits for host command to proceed with new detection cycles. The port was delivering power before host crash but was configured to be forced shut when host crashes."
 * @ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_HOST_CRASH_FORCE_SHUTDOWN: Host crash force shutdown (PD692x0 0x46)         
 *      "Port is off: An enabled port was forced to be shut down at host crash. Port is off - after host crash the port is off and waits for host command to proceed with new detection cycles. The port was enabled and not delivering power before host crash and was configured to be forced shut when host crashes."
 * @ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_RECOVERY_UDL: Recovery UDL (PD692x0 0x48)                                    
 *      "Port is off: Recovery UDL. During crash a recovery port delivering power was disconnected due to UDL."
 * @ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_RECOVERY_PG_EVENT: Recovery PG Event (PD692x0 0x49)                          
 *      "Port is off: Recovery PG Event. During crash a recovery port delivering power was disconnected due to PG event."
 * @ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_RECOVERY_OVL: Recovery OVL (PD692x0 0x4A)                                    
 *      "Port is off: Recovery OVL. During crash a recovery port delivering power was disconnected due to OVL."
 * @ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_DVDT_FAIL_STARTUP: DVDT fail during startup (PD692x0 0x4D)                   
 *      "Port is off: DVDT fail during startup. DVDT algorithm that checks power up sequence failed to power up the port."

 **error_condition**  
  A variable indicating the status of implementation-specific fault conditions or optionally other
  system faults that prevent the PSE from meeting the specifications in Table 33–11 and that require
  the PSE not to source power. These error conditions are different from those monitored by the state
  diagrams in Figure 33–10.  
  Values:  
  FALSE: No fault indication.  
  TRUE: A fault indication exists.
 */ 
enum ethtool_c33_pse_ext_substate_error_condition {
    ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_NON_EXISTING_PORT,
    ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_UNDEFINED_PORT,
    ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_INTERNAL_HW_FAULT,
    ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_INTERNAL_HW_FAULT_2,
    ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_COMM_ERROR_AFTER_FORCE_ON,
    ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_UNKNOWN_PORT_STATUS,
    ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_HOST_CRASH_TURN_OFF,
    ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_HOST_CRASH_FORCE_SHUTDOWN,
    ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_RECOVERY_UDL,
    ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_RECOVERY_PG_EVENT,
    ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_RECOVERY_OVL,
    ETHTOOL_C33_PSE_EXT_SUBSTATE_ERROR_CONDITION_DVDT_FAIL_STARTUP,
};

/**                                                                                  
 * enum ethtool_c33_pse_ext_substate_mr_pse_enable - mr_pse_enable states               
 *      functions. IEEE 802.3-2022 33.2.4.4 Variables                                
 *                                                                                  
 * @ETHTOOL_C33_PSE_EXT_SUBSTATE_MR_PSE_ENABLE_DISABLE_PIN_ACTIVE: Disable pin active (PD692x0 0x08)                           
 *      "Port is off: 'Disable all ports' pin is active. Hardware pin disables all ports."
 * @ETHTOOL_C33_PSE_EXT_SUBSTATE_MR_PSE_ENABLE_DISABLE_PDU_FLAG_FORCE_ON: Disable PDU flag during force on (PD692x0 0x2F)      
 *      "Port is off: Disable PDU flag raised during Force On."

 **mr_pse_enable**  
  A control variable that selects PSE operation and test functions. This variable is provided by a
  management interface that may be mapped to the PSE Control register PSE Enable bits (11.1:0), as
  described below, or other equivalent functions.  
  Values:  
  disable: All PSE functions disabled (behavior is as if there was no PSE functionality).  
  enable: Normal PSE operation.  
  force_power: Test mode selected that causes the PSE to apply power to the PI when there are no detected error conditions.
 */ 
enum ethtool_c33_pse_ext_substate_mr_pse_enable {
    ETHTOOL_C33_PSE_EXT_SUBSTATE_MR_PSE_ENABLE_DISABLE_PIN_ACTIVE,
    ETHTOOL_C33_PSE_EXT_SUBSTATE_MR_PSE_ENABLE_DISABLE_PDU_FLAG_FORCE_ON,
};

/**                                                                                  
 * enum ethtool_c33_pse_ext_substate_option_vport_lim - option_vport_lim states           
 *      functions. IEEE 802.3-2022 33.2.4.4 Variables                                
 *                                                                                  
 * @ETHTOOL_C33_PSE_EXT_SUBSTATE_OPTION_VPORT_LIM_HIGH_VOLTAGE: Main supply voltage is high (PD692x0 0x06)                     
 *      "Port is off: Main supply voltage is high. Mains voltage is higher than Max Voltage limit."
 * @ETHTOOL_C33_PSE_EXT_SUBSTATE_OPTION_VPORT_LIM_HIGH_VOLTAGE_FORCED: Supply voltage higher than settings (PD692x0 0x2D)     
 *      "Port is off: Supply voltage higher than settings. These errors appear only after port is in Force On."
 * @ETHTOOL_C33_PSE_EXT_SUBSTATE_OPTION_VPORT_LIM_LOW_VOLTAGE: Main supply voltage is low (PD692x0 0x07)                       
 *      "Port is off: Main supply voltage is low. Mains voltage is lower than Min Voltage limit."
 * @ETHTOOL_C33_PSE_EXT_SUBSTATE_OPTION_VPORT_LIM_LOW_VOLTAGE_FORCED: Supply voltage lower than settings (PD692x0 0x2E)       
 *      "Port is off: Supply voltage lower than settings."
 * @ETHTOOL_C33_PSE_EXT_SUBSTATE_OPTION_VPORT_LIM_RECOVERY_VOLTAGE_INJECTION: Recovery voltage injection (PD692x0 0x4C)       
 *      "Port is off: Recovery Voltage injection. Voltage was applied to the port from external source, during or before crash."

 **option_vport_lim**  
  This optional variable indicates if VPSE is out of the operating range during normal operating state.  
  Values:  
  FALSE: VPSE is within the VPort_PSE operating range as defined in Table 33–11.  
  TRUE: VPSE is outside of the VPort_PSE operating range as defined in Table 33–11.
 */ 
enum ethtool_c33_pse_ext_substate_option_vport_lim {
    ETHTOOL_C33_PSE_EXT_SUBSTATE_OPTION_VPORT_LIM_HIGH_VOLTAGE,
    ETHTOOL_C33_PSE_EXT_SUBSTATE_OPTION_VPORT_LIM_HIGH_VOLTAGE_FORCED,
    ETHTOOL_C33_PSE_EXT_SUBSTATE_OPTION_VPORT_LIM_LOW_VOLTAGE,
    ETHTOOL_C33_PSE_EXT_SUBSTATE_OPTION_VPORT_LIM_LOW_VOLTAGE_FORCED,
    ETHTOOL_C33_PSE_EXT_SUBSTATE_OPTION_VPORT_LIM_RECOVERY_VOLTAGE_INJECTION,
};

/**                                                                                  
 * enum ethtool_c33_pse_ext_substate_ovld_detected - ovld_detected states        
 *      functions. IEEE 802.3-2022 33.2.4.4 Variables                                
 *                                                                                  
 * @ETHTOOL_C33_PSE_EXT_SUBSTATE_OVLD_DETECTED_OVERLOAD: Overload state (PD692x0 0x1F)                                          
 *      "Port is off: Overload state. Overload state according to 802.3AF/AT (current is above Icut) OR (PM3 != 0 and (PD class report > user predefined power value))."
 * @ETHTOOL_C33_PSE_EXT_SUBSTATE_OVLD_DETECTED_OVERLOAD_FORCED: Forced power error due to overload (PD692x0 0x31)              
 *      "Port is off: Forced power error due to Overload. Overload condition according to 802.3AF/AT during Force On."

 **ovld_detected**  
  A variable indicating if the PSE output current has been in an overload condition (see 33.2.7.6) for at least TCUT of a one-second sliding time.  
  Values:  
  FALSE: The PSE has not detected an overload condition.  
  TRUE: The PSE has detected an overload condition.
 */ 
enum ethtool_c33_pse_ext_substate_ovld_detected {
    ETHTOOL_C33_PSE_EXT_SUBSTATE_OVLD_DETECTED_OVERLOAD,
    ETHTOOL_C33_PSE_EXT_SUBSTATE_OVLD_DETECTED_OVERLOAD_FORCED,
};

/**                                                                                  
 * enum ethtool_c33_pse_ext_substate_pd_dll_power_type - pd_dll_power_type states    
 *      functions. IEEE 802.3-2022 33.2.4.4 Variables                                
 *                                                                                  
 * @ETHTOOL_C33_PSE_EXT_SUBSTATE_PD_DLL_POWER_TYPE_NON_802_3AF_AT_DEVICE: Non-802.3AF/AT powered device (PD692x0 0x1C)           
 *      "Port is off: Non-802.3AF/AT powered device. Non-standard PD connected."

 **pd_dll_power_type**  
  A control variable initially output by the PSE power control state diagram (Figure 33–27), which can be updated by LLDP (see Table 33–26), that indicates the type of PD as advertised through Data Link Layer classification.  
  Values:  
  1: PD is a Type 1 PD (default)  
  2: PD is a Type 2 PD
 */ 
enum ethtool_c33_pse_ext_substate_pd_dll_power_type {
    ETHTOOL_C33_PSE_EXT_SUBSTATE_PD_DLL_POWER_TYPE_NON_802_3AF_AT_DEVICE,
};

/**                                                                                  
 * enum ethtool_c33_pse_ext_substate_power_not_available - power_not_available states
 *      functions. IEEE 802.3-2022 33.2.4.4 Variables                                
 *                                                                                  
 * @ETHTOOL_C33_PSE_EXT_SUBSTATE_POWER_NOT_AVAILABLE_BUDGET_EXCEEDED: Power budget exceeded (PD692x0 0x20)                     
 *      "Port is off: Power budget exceeded. Power Management function shuts down port, due to lack of power. Port is shut down or remains off."
 * @ETHTOOL_C33_PSE_EXT_SUBSTATE_POWER_NOT_AVAILABLE_PM_STATIC: Power Management-Static (PD692x0 0x3C)                         
 *      "Power Management-Static. Calculated power > power limit."
 * @ETHTOOL_C33_PSE_EXT_SUBSTATE_POWER_NOT_AVAILABLE_PM_STATIC_OVL: Power Management-Static-ovl (PD692x0 0x3D)                 
 *      "Power Management-Static-ovl. Port Power up was denied due to (PD class report power > user predefined power value). Note: Power denied counter will advance."
 * @ETHTOOL_C33_PSE_EXT_SUBSTATE_POWER_NOT_AVAILABLE_ERROR_MANAGEMENT_STATIC: Force Power Error Management Static (PD692x0 0x3E)
 *      "Force Power Error Management Static. Calculated power > power limit during Force On."
 * @ETHTOOL_C33_PSE_EXT_SUBSTATE_POWER_NOT_AVAILABLE_ERROR_MANAGEMENT_STATIC_OVL: Force Power Error Management Static-ovl (PD692x0 0x3F)
 *      "Force Power Error Management Static-ovl. PD class report > user predefined power value during Force On. Note: Power denied counter will advance."
 * @ETHTOOL_C33_PSE_EXT_SUBSTATE_POWER_NOT_AVAILABLE_INSUFFICIENT_POWER_FORCE_ON: Port is not ON during Force On due to exceeded max power level or insufficient power (PD692x0 0x32)
 *      "Port is not ON during Force On due to exceeded max power level or insufficient power."

 **power_not_available**  
  Variable that is asserted in an implementation-dependent manner when the PSE is no longer capable of sourcing sufficient power to support the attached PD. Sufficient power is defined by classification; see 33.2.6.  
  Values:  
  FALSE: PSE is capable to continue to source power to a PD.  
  TRUE: PSE is no longer capable of sourcing power to a PD.
 */ 
enum ethtool_c33_pse_ext_substate_power_not_available {
    ETHTOOL_C33_PSE_EXT_SUBSTATE_POWER_NOT_AVAILABLE_BUDGET_EXCEEDED,
    ETHTOOL_C33_PSE_EXT_SUBSTATE_POWER_NOT_AVAILABLE_PM_STATIC,
    ETHTOOL_C33_PSE_EXT_SUBSTATE_POWER_NOT_AVAILABLE_PM_STATIC_OVL,
    ETHTOOL_C33_PSE_EXT_SUBSTATE_POWER_NOT_AVAILABLE_ERROR_MANAGEMENT_STATIC,
    ETHTOOL_C33_PSE_EXT_SUBSTATE_POWER_NOT_AVAILABLE_ERROR_MANAGEMENT_STATIC_OVL,
    ETHTOOL_C33_PSE_EXT_SUBSTATE_POWER_NOT_AVAILABLE_INSUFFICIENT_POWER_FORCE_ON,
};

/**                                                                                  
 * enum ethtool_c33_pse_ext_substate_short_detected - short_detected states          
 *      functions. IEEE 802.3-2022 33.2.4.4 Variables                                
 *                                                                                  
 * @ETHTOOL_C33_PSE_EXT_SUBSTATE_SHORT_DETECTED_SHORT_CIRCUIT_FORCED: Force Power Error Short Circuit (PD692x0 0x38)             
 *      "Force Power Error Short Circuit. Short condition during Force On."
 * @ETHTOOL_C33_PSE_EXT_SUBSTATE_SHORT_DETECTED_RECOVERY_SC: Recovery short circuit (PD692x0 0x4B)                              
 *      "Recovery SC. During crash a recovery port delivering power was disconnected due to SC."

 **short_detected**  
  A variable indicating if the PSE output current has been in a short circuit condition for TLIM within
  a sliding window (see 33.2.7.7).  
  Values:  
  FALSE: The PSE has not detected a short circuit condition.  
  TRUE: The PSE has detected qualified short circuit condition.
 */ 
enum ethtool_c33_pse_ext_substate_short_detected {
    ETHTOOL_C33_PSE_EXT_SUBSTATE_SHORT_DETECTED_SHORT_CIRCUIT_FORCED,
    ETHTOOL_C33_PSE_EXT_SUBSTATE_SHORT_DETECTED_RECOVERY_SC,
};

/**                                                                                  
 * enum ethtool_c33_pse_ext_substate_tinrush_timer - tinrush_timer states             
 *      functions. IEEE 802.3-2022 33.2.4.5 Timers                                   
 *                                                                                  
 * @ETHTOOL_C33_PSE_EXT_SUBSTATE_TINRUSH_TIMER_FAIL_STARTUP: DVDT fail during startup (PD692x0 0x4D)                            
 *      "Port is off: DVDT fail during startup. DVDT algorithm that checks power up sequence failed to power up the port."

 **tinrush_timer**  
  A timer used to monitor the duration of the inrush event; see TInrush in Table 33–11.
 */ 
enum ethtool_c33_pse_ext_substate_tinrush_timer {
    ETHTOOL_C33_PSE_EXT_SUBSTATE_TINRUSH_TIMER_FAIL_STARTUP,
};


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

