Return-Path: <netdev+bounces-244978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9244ACC47B6
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 17:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 10BDA3005018
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 16:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528FE2D8382;
	Tue, 16 Dec 2025 16:57:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBBB2D8384;
	Tue, 16 Dec 2025 16:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765904255; cv=none; b=BsP2/SQDoCFUw+cDKjTva8fqdkEhx0o8f1mCArojVxEuH37+Unosn2HCRh7QmhD/5DP/0liN1FvecUa6CgaHhl7cqOjZFz809bFidEFwGm6yUk9VjW7ZJt7Axuwm3dyRWLMyF4PCIqF8Czc7ks8BBaPw31dGS63ZQxkghTHfuiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765904255; c=relaxed/simple;
	bh=jWGIeKMsr00H3kNJGDk1rlTSKGdOhhgOAKV0njmVJZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aSIW7gZ76odkbO7Vo/AnXJd1yecYgNasy2nZeYy1FTRsEtEDSQmQ/iFqC7veycPZi0VZyv270f1CXD1hYvT15YfUKA/iadNvgRuVTi4C9zcjCte9Nm7WGdMqWuy7RGChCxaUlik7kzyCK6Y2mKnxjgfki5YGktd4W+sMNtB5dRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 14B2F61E647AB;
	Tue, 16 Dec 2025 17:56:47 +0100 (CET)
Message-ID: <e94d7fca-36f8-4acd-bd84-06f2cc9c4246@molgen.mpg.de>
Date: Tue, 16 Dec 2025 17:56:46 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: hci_sync: Initial LE Channel Sounding
 support by defining required HCI command/event structures.
To: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 anubhavg@qti.qualcomm.com, mohamull@qti.qualcomm.com,
 hbandi@qti.qualcomm.com, Simon Horman <horms@kernel.org>,
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251216113753.3969183-1-naga.akella@oss.qualcomm.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20251216113753.3969183-1-naga.akella@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Naga,


Thank you for your patch. Just a formally to please remove the 
dot/period at the end of the summary/title (subject) and also make it a 
statement by adding a verb in imperative mood.


Am 16.12.25 um 12:37 schrieb Naga Bhavani Akella:
> 1. Implementing the LE Event Mask to include events required for
>     LE Channel Sounding.

I’d use imperative mood (also below):

Implement …

> 2. Enabling the Channel Sounding feature bit in the
>     LE Host Supported Features command.
> 3. Defining HCI command and event structures necessary for
>     LE Channel Sounding functionality.

Is a test already possible?

> Signed-off-by: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
> ---
>   include/net/bluetooth/hci.h      | 323 +++++++++++++++++++++++++++++++
>   include/net/bluetooth/hci_core.h |   6 +
>   net/bluetooth/hci_sync.c         |  15 ++
>   3 files changed, 344 insertions(+)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index a27cd3626b87..33ec8ddd2119 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -654,6 +654,8 @@ enum {
>   #define HCI_LE_ISO_BROADCASTER		0x40
>   #define HCI_LE_ISO_SYNC_RECEIVER	0x80
>   #define HCI_LE_LL_EXT_FEATURE		0x80
> +#define HCI_LE_CHANNEL_SOUNDING		0x40
> +#define HCI_LE_CHANNEL_SOUNDING_HOST	0x80
>   
>   /* Connection modes */
>   #define HCI_CM_ACTIVE	0x0000
> @@ -2269,6 +2271,204 @@ struct hci_cp_le_read_all_remote_features {
>   	__u8	 pages;
>   } __packed;
>   
> +/* Channel Sounding Commands */
> +#define HCI_OP_LE_CS_RD_LOCAL_SUPP_CAP	0x2089
> +struct hci_rp_le_cs_rd_local_supp_cap {
> +	__u8	status;
> +	__u8	num_config_supported;
> +	__le16	max_consecutive_procedures_supported;
> +	__u8	num_antennas_supported;
> +	__u8	max_antenna_paths_supported;
> +	__u8	roles_supported;
> +	__u8	modes_supported;
> +	__u8	rtt_capability;
> +	__u8	rtt_aa_only_n;
> +	__u8	rtt_sounding_n;
> +	__u8	rtt_random_payload_n;
> +	__le16	nadm_sounding_capability;
> +	__le16	nadm_random_capability;
> +	__u8	cs_sync_phys_supported;
> +	__le16	subfeatures_supported;
> +	__le16	t_ip1_times_supported;
> +	__le16	t_ip2_times_supported;
> +	__le16	t_fcs_times_supported;
> +	__le16	t_pm_times_supported;
> +	__u8	t_sw_time_supported;
> +	__u8	tx_snr_capability;
> +} __packed;
> +
> +#define HCI_OP_LE_CS_RD_RMT_SUPP_CAP		0x208A
> +struct hci_cp_le_cs_rd_local_supp_cap {
> +	__le16	conn_hdl;
> +} __packed;
> +
> +#define HCI_OP_LE_CS_WR_CACHED_RMT_SUPP_CAP	0x208B
> +struct hci_cp_le_cs_wr_cached_rmt_supp_cap {
> +	__le16	conn_hdl;
> +	__u8	num_config_supported;
> +	__le16	max_consecutive_procedures_supported;
> +	__u8	num_antennas_supported;
> +	__u8	max_antenna_paths_supported;
> +	__u8	roles_supported;
> +	__u8	modes_supported;
> +	__u8	rtt_capability;
> +	__u8	rtt_aa_only_n;
> +	__u8	rtt_sounding_n;
> +	__u8	rtt_random_payload_n;
> +	__le16	nadm_sounding_capability;
> +	__le16	nadm_random_capability;
> +	__u8	cs_sync_phys_supported;
> +	__le16	subfeatures_supported;
> +	__le16	t_ip1_times_supported;
> +	__le16	t_ip2_times_supported;
> +	__le16	t_fcs_times_supported;
> +	__le16	t_pm_times_supported;
> +	__u8	t_sw_time_supported;
> +	__u8	tx_snr_capability;
> +} __packed;
> +
> +struct hci_rp_le_cs_wr_cached_rmt_supp_cap {
> +	__u8	status;
> +	__le16	conn_hdl;
> +} __packed;
> +
> +#define HCI_OP_LE_CS_SEC_ENABLE			0x208C
> +struct hci_cp_le_cs_sec_enable {
> +	__le16	conn_hdl;
> +} __packed;
> +
> +#define HCI_OP_LE_CS_SET_DEFAULT_SETTINGS	0x208D
> +struct hci_cp_le_cs_set_default_settings {
> +	__le16  conn_hdl;
> +	__u8    role_enable;
> +	__u8    cs_sync_ant_sel;
> +	__s8    max_tx_power;
> +} __packed;
> +
> +struct hci_rp_le_cs_set_default_settings {
> +	__u8    status;
> +	__le16  conn_hdl;
> +} __packed;
> +
> +#define HCI_OP_LE_CS_RD_RMT_FAE_TABLE		0x208E
> +struct hci_cp_le_cs_rd_rmt_fae_table {
> +	__le16	conn_hdl;
> +} __packed;
> +
> +#define HCI_OP_LE_CS_WR_CACHED_RMT_FAE_TABLE	0x208F
> +struct hci_cp_le_cs_wr_rmt_cached_fae_table {
> +	__le16	conn_hdl;
> +	__u8	remote_fae_table[72];
> +} __packed;
> +
> +struct hci_rp_le_cs_wr_rmt_cached_fae_table {
> +	__u8    status;
> +	__le16  conn_hdl;
> +} __packed;
> +
> +#define HCI_OP_LE_CS_CREATE_CONFIG		0x2090
> +struct hci_cp_le_cs_create_config {
> +	__le16	conn_hdl;
> +	__u8	config_id;
> +	__u8	create_context;
> +	__u8	main_mode_type;
> +	__u8	sub_mode_type;
> +	__u8	min_main_mode_steps;
> +	__u8	max_main_mode_steps;
> +	__u8	main_mode_repetition;
> +	__u8	mode_0_steps;
> +	__u8	role;
> +	__u8	rtt_type;
> +	__u8	cs_sync_phy;
> +	__u8	channel_map[10];
> +	__u8	channel_map_repetition;
> +	__u8	channel_selection_type;
> +	__u8	ch3c_shape;
> +	__u8	ch3c_jump;
> +	__u8	reserved;
> +} __packed;
> +
> +#define HCI_OP_LE_CS_REMOVE_CONFIG		0x2091
> +struct hci_cp_le_cs_remove_config {
> +	__le16	conn_hdl;
> +	__u8	config_id;
> +} __packed;
> +
> +#define HCI_OP_LE_CS_SET_CH_CLASSIFICATION	0x2092
> +struct hci_cp_le_cs_set_ch_classification {
> +	__u8	ch_classification[10];
> +} __packed;
> +
> +struct hci_rp_le_cs_set_ch_classification {
> +	__u8    status;
> +} __packed;
> +
> +#define HCI_OP_LE_CS_SET_PROC_PARAM		0x2093
> +struct hci_cp_le_cs_set_proc_param {
> +	__le16  conn_hdl;
> +	__u8	config_id;
> +	__le16	max_procedure_len;
> +	__le16	min_procedure_interval;
> +	__le16	max_procedure_interval;
> +	__le16	max_procedure_count;
> +	__u8	min_subevent_len[3];
> +	__u8	max_subevent_len[3];
> +	__u8	tone_antenna_config_selection;
> +	__u8	phy;
> +	__u8	tx_power_delta;
> +	__u8	preferred_peer_antenna;
> +	__u8	snr_control_initiator;
> +	__u8	snr_control_reflector;
> +} __packed;
> +
> +struct hci_rp_le_cs_set_proc_param {
> +	__u8    status;
> +	__le16  conn_hdl;
> +} __packed;
> +
> +#define HCI_OP_LE_CS_SET_PROC_ENABLE		0x2094
> +struct hci_cp_le_cs_set_proc_param {
> +	__le16  conn_hdl;
> +	__u8	config_id;
> +	__u8	enable;
> +} __packed;
> +
> +#define HCI_OP_LE_CS_TEST			0x2095
> +struct hci_cp_le_cs_test {
> +	__u8	main_mode_type;
> +	__u8	sub_mode_type;
> +	__u8	main_mode_repetition;
> +	__u8	mode_0_steps;
> +	__u8	role;
> +	__u8	rtt_type;
> +	__u8	cs_sync_phy;
> +	__u8	cs_sync_antenna_selection;
> +	__u8	subevent_len[3];
> +	__le16	subevent_interval;
> +	__u8	max_num_subevents;
> +	__u8	transmit_power_level;
> +	__u8	t_ip1_time;
> +	__u8	t_ip2_time;
> +	__u8	t_fcs_time;
> +	__u8	t_pm_time;
> +	__u8	t_sw_time;
> +	__u8	tone_antenna_config_selection;
> +	__u8	reserved;
> +	__u8	snr_control_initiator;
> +	__u8	snr_control_reflector;
> +	__le16	drbg_nonce;
> +	__u8	channel_map_repetition;
> +	__le16	override_config;
> +	__u8	override_parameters_length;
> +	__u8	override_parameters_data[];
> +} __packed;
> +
> +struct hci_rp_le_cs_test {
> +	__u8    status;
> +} __packed;
> +
> +#define HCI_OP_LE_CS_TEST_END			0x2096
> +
>   /* ---- HCI Events ---- */
>   struct hci_ev_status {
>   	__u8    status;
> @@ -2960,6 +3160,129 @@ struct hci_evt_le_read_all_remote_features_complete {
>   	__u8    features[248];
>   } __packed;
>   
> +/* Channel Sounding Events */
> +#define HCI_EVT_LE_CS_READ_RMT_SUPP_CAP_COMPLETE	0x2C
> +struct hci_evt_le_cs_read_rmt_supp_cap_complete {
> +	__u8	status;
> +	__le16	conn_hdl;
> +	__u8	num_configs_supp;
> +	__le16	max_consec_proc_supp;
> +	__u8	num_ant_supp;
> +	__u8	max_ant_path_supp;
> +	__u8	roles_supp;
> +	__u8	modes_supp;
> +	__u8	rtt_cap;
> +	__u8	rtt_aa_only_n;
> +	__u8	rtt_sounding_n;
> +	__u8	rtt_rand_payload_n;
> +	__le16	nadm_sounding_cap;
> +	__le16	nadm_rand_cap;
> +	__u8	cs_sync_phys_supp;
> +	__le16	sub_feat_supp;
> +	__le16	t_ip1_times_supp;
> +	__le16	t_ip2_times_supp;
> +	__le16	t_fcs_times_supp;
> +	__le16	t_pm_times_supp;
> +	__u8	t_sw_times_supp;
> +	__u8	tx_snr_cap;
> +} __packed;
> +
> +#define HCI_EVT_LE_CS_READ_RMT_FAE_TABLE_COMPLETE	0x2D
> +struct hci_evt_le_cs_read_rmt_fae_table_complete {
> +	__u8	status;
> +	__le16	conn_hdl;
> +	__u8	remote_fae_table[72];
> +} __packed;
> +
> +#define HCI_EVT_LE_CS_SECURITY_ENABLE_COMPLETE		0x2E
> +struct hci_evt_le_cs_security_enable_complete {
> +	__u8	status;
> +	__le16	conn_hdl;
> +} __packed;
> +
> +#define HCI_EVT_LE_CS_CONFIG_COMPLETE			0x2F
> +struct hci_evt_le_cs_config_complete {
> +	__u8	status;
> +	__le16	conn_hdl;
> +	__u8	config_id;
> +	__u8	action;
> +	__u8	main_mode_type;
> +	__u8	sub_mode_type;
> +	__u8	min_main_mode_steps;
> +	__u8	max_main_mode_steps;
> +	__u8	main_mode_rep;
> +	__u8	mode_0_steps;
> +	__u8	role;
> +	__u8	rtt_type;
> +	__u8	cs_sync_phy;
> +	__u8	channel_map[10];
> +	__u8	channel_map_rep;
> +	__u8	channel_sel_type;
> +	__u8	ch3c_shape;
> +	__u8	ch3c_jump;
> +	__u8	reserved;
> +	__u8	t_ip1_time;
> +	__u8	t_ip2_time;
> +	__u8	t_fcs_time;
> +	__u8	t_pm_time;
> +} __packed;
> +
> +#define HCI_EVT_LE_CS_PROCEDURE_ENABLE_COMPLETE		0x30
> +struct hci_evt_le_cs_procedure_enable_complete {
> +	__u8	status;
> +	__le16	conn_hdl;
> +	__u8	config_id;
> +	__u8	state;
> +	__u8	tone_ant_config_sel;
> +	__s8	sel_tx_pwr;
> +	__u8	sub_evt_len[3];
> +	__u8	sub_evts_per_evt;
> +	__le16	sub_evt_intrvl;
> +	__le16	evt_intrvl;
> +	__le16	proc_intrvl;
> +	__le16	proc_counter;
> +	__le16	max_proc_len;
> +} __packed;
> +
> +#define HCI_EVT_LE_CS_SUBEVENT_RESULT			0x31
> +struct hci_evt_le_cs_subevent_result {
> +	__le16	conn_hdl;
> +	__u8	config_id;
> +	__le16	start_acl_conn_evt_counter;
> +	__le16	proc_counter;
> +	__le16	freq_comp;
> +	__u8	ref_pwr_lvl;
> +	__u8	proc_done_status;
> +	__u8	subevt_done_status;
> +	__u8	abort_reason;
> +	__u8	num_ant_paths;
> +	__u8	num_steps_reported;
> +	__u8	step_mode[0]; /* depends on num_steps_reported */
> +	__u8	step_channel[0]; /* depends on num_steps_reported */
> +	__u8	step_data_length[0]; /* depends on num_steps_reported */
> +	__u8	step_data[0]; /* depends on num_steps_reported */
> +} __packed;
> +
> +#define HCI_EVT_LE_CS_SUBEVENT_RESULT_CONTINUE		0x32
> +struct hci_evt_le_cs_subevent_result_continue {
> +	__le16	conn_hdl;
> +	__u8	config_id;
> +	__u8	proc_done_status;
> +	__u8	subevt_done_status;
> +	__u8	abort_reason;
> +	__u8	num_ant_paths;
> +	__u8	num_steps_reported;
> +	__u8	step_mode[0]; /* depends on num_steps_reported */
> +	__u8	step_channel[0]; /* depends on num_steps_reported */
> +	__u8	step_data_length[0]; /* depends on num_steps_reported */
> +	__u8	step_data[0]; /* depends on num_steps_reported */
> +} __packed;
> +
> +#define HCI_EVT_LE_CS_TEST_END_COMPLETE			0x33
> +struct hci_evt_le_cs_test_end_complete {
> +	__u8	status;
> +} __packed;
> +
>   #define HCI_EV_VENDOR			0xff
>   
>   /* Internal events generated by Bluetooth stack */
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 4263e71a23ef..0152299a00b9 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -2071,6 +2071,12 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
>   #define ll_ext_feature_capable(dev) \
>   	((dev)->le_features[7] & HCI_LE_LL_EXT_FEATURE)
>   
> +/* Channel sounding support */
> +#define chann_sounding_capable(dev) \
> +	(((dev)->le_features[5] & HCI_LE_CHANNEL_SOUNDING))
> +#define chann_sounding_host_capable(dev) \
> +	(((dev)->le_features[5] & HCI_LE_CHANNEL_SOUNDING_HOST))
> +
>   #define mws_transport_config_capable(dev) (((dev)->commands[30] & 0x08) && \
>   	(!hci_test_quirk((dev), HCI_QUIRK_BROKEN_MWS_TRANSPORT_CONFIG)))
>   
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index a9f5b1a68356..67b2c55ec043 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -4427,6 +4427,17 @@ static int hci_le_set_event_mask_sync(struct hci_dev *hdev)
>   		events[4] |= 0x02;	/* LE BIG Info Advertising Report */
>   	}
>   
> +	if (chann_sounding_capable(hdev)) {
> +		/* Channel Sounding events */
> +		events[5] |= 0x08;	/* LE CS Read Remote Supported Cap Complete event */
> +		events[5] |= 0x10;	/* LE CS Read Remote FAE Table Complete event */
> +		events[5] |= 0x20;	/* LE CS Security Enable Complete event */
> +		events[5] |= 0x40;	/* LE CS Config Complete event */
> +		events[5] |= 0x80;	/* LE CS Procedure Enable Complete event */
> +		events[6] |= 0x01;	/* LE CS Subevent Result event */
> +		events[6] |= 0x02;	/* LE CS Subevent Result Continue event */
> +		events[6] |= 0x04;	/* LE CS Test End Complete event */
> +	}
>   	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EVENT_MASK,
>   				     sizeof(events), events, HCI_CMD_TIMEOUT);
>   }
> @@ -4572,6 +4583,10 @@ static int hci_le_set_host_feature_sync(struct hci_dev *hdev)
>   	cp.bit_number = 32;
>   	cp.bit_value = iso_enabled(hdev) ? 0x01 : 0x00;
>   
> +	/* Channel Sounding (Host Support) */
> +	cp.bit_number = 47;
> +	cp.bit_value = chann_sounding_capable(hdev) ? 0x01 : 0x00;
> +
>   	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_HOST_FEATURE,
>   				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
>   }


Kind regards,

Paul

