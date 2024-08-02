Return-Path: <netdev+bounces-115313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FF4945CBE
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 13:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 361D41F21FDD
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 11:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411DE1DF67F;
	Fri,  2 Aug 2024 11:03:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D6E1DD38A;
	Fri,  2 Aug 2024 11:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722596614; cv=none; b=MMBRQi+mJ376yakf5Cga8Nwc6OLIgwOcs6Kp1o21J6SSEKplA4u1Xsh4CF/oCFa2KnsdlmGADYgVZnICnZJZDLg6sT9AvUYqLtlHM92M7EpYD7UWyBJEL1fzrhCxcDSnUMf693GvKhfnBKt7/9DIkCxsg9KUXiN1rv5mZPHjAew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722596614; c=relaxed/simple;
	bh=SB9mEpxznilnfo4iJddgBMkxVVrSuM6C6tkONkE+FbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ChD02SK9ejGb97c5zpuyVSNTyTCmOyYivv3P9v51xPcBBxlNuwNk9+/2WQ8CZ0zcyIwDNp4W/JBPuG87uXjY4Z9rTeSQq8cgXJ6oo3MwYoL9aYuhd13GOugtifwKsjq60cCSIb5roYt66b2mLalf+tIni/H8NvFDdBUE+4cnJNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 58FB961E5FE01;
	Fri,  2 Aug 2024 13:02:35 +0200 (CEST)
Message-ID: <a23140d2-1e82-4cfc-9659-97333ef011b5@molgen.mpg.de>
Date: Fri, 2 Aug 2024 13:02:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] Bluetooth: hci_uart: Add support for Amlogic HCI
 UART
To: Yang Li <yang.li@amlogic.com>, Ye He <ye.he@amlogic.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240802-btaml-v3-0-d8110bf9963f@amlogic.com>
 <20240802-btaml-v3-2-d8110bf9963f@amlogic.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240802-btaml-v3-2-d8110bf9963f@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Yang,


Thank you for the patch. Some nits and formal things.

Am 02.08.24 um 11:39 schrieb Yang Li via B4 Relay:
> From: Yang Li <yang.li@amlogic.com>
> 
> Add support for Amlogic Bluetooth controller over HCI UART.
> In order to send the final firmware at full speed(4Mbps).

I’d add a space before (. What is the current speed without the patch? 
Maybe also document, what firmware file took how lang.

I’d welcome a more elaborate commit message for a diffstat with almost 
800 lines. What datasheet did you use? Maybe paste the new log messages 
and document your test system.

> Co-developed-by: Ye He <ye.he@amlogic.com>
> Signed-off-by: Ye He <ye.he@amlogic.com>
> Signed-off-by: Yang Li <yang.li@amlogic.com>
> ---
>   drivers/bluetooth/Kconfig     |  12 +
>   drivers/bluetooth/Makefile    |   1 +
>   drivers/bluetooth/hci_aml.c   | 756 ++++++++++++++++++++++++++++++++++++++++++
>   drivers/bluetooth/hci_ldisc.c |   8 +-
>   drivers/bluetooth/hci_uart.h  |   8 +-
>   5 files changed, 782 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
> index 769fa288179d..18767b54df35 100644
> --- a/drivers/bluetooth/Kconfig
> +++ b/drivers/bluetooth/Kconfig
> @@ -274,6 +274,18 @@ config BT_HCIUART_MRVL
>   
>   	  Say Y here to compile support for HCI MRVL protocol.
>   
> +config BT_HCIUART_AML
> +	bool "Amlogic protocol support"
> +	depends on BT_HCIUART
> +	depends on BT_HCIUART_SERDEV
> +	select BT_HCIUART_H4
> +	select FW_LOADER
> +	help
> +	  The Amlogic protocol support enables Bluetooth HCI over serial
> +	  port interface for Amlogic Bluetooth controllers.
> +
> +	  Say Y here to compile support for HCI AML protocol.
> +
>   config BT_HCIBCM203X
>   	tristate "HCI BCM203x USB driver"
>   	depends on USB
> diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
> index 0730d6684d1a..81856512ddd0 100644
> --- a/drivers/bluetooth/Makefile
> +++ b/drivers/bluetooth/Makefile
> @@ -51,4 +51,5 @@ hci_uart-$(CONFIG_BT_HCIUART_BCM)	+= hci_bcm.o
>   hci_uart-$(CONFIG_BT_HCIUART_QCA)	+= hci_qca.o
>   hci_uart-$(CONFIG_BT_HCIUART_AG6XX)	+= hci_ag6xx.o
>   hci_uart-$(CONFIG_BT_HCIUART_MRVL)	+= hci_mrvl.o
> +hci_uart-$(CONFIG_BT_HCIUART_AML)	+= hci_aml.o
>   hci_uart-objs				:= $(hci_uart-y)
> diff --git a/drivers/bluetooth/hci_aml.c b/drivers/bluetooth/hci_aml.c
> new file mode 100644
> index 000000000000..cc6627788611
> --- /dev/null
> +++ b/drivers/bluetooth/hci_aml.c
> @@ -0,0 +1,756 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
> +/*
> + * Copyright (C) 2024 Amlogic, Inc. All rights reserved
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/property.h>
> +#include <linux/of.h>
> +#include <linux/serdev.h>
> +#include <linux/clk.h>
> +#include <linux/firmware.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/regulator/consumer.h>
> +#include <net/bluetooth/bluetooth.h>
> +#include <net/bluetooth/hci_core.h>
> +#include <net/bluetooth/hci.h>
> +
> +#include "hci_uart.h"

[…]

> +/* The TCI command is private command, which is used to configure before BT

Used to configure what? Maybe:

… is *a* private, executed(?) before BT chip startup …

> + * chip startup, contains update baudrate, update firmware, set public addr.

s/, contains/ to/

> + *
> + * op_code |      op_len           | op_addr | parameter   |
> + * --------|-----------------------|---------|-------------|
> + *   2B    | 1B len(addr+param)    |    4B   |  len(param) |
> + */
> +static int aml_send_tci_cmd(struct hci_dev *hdev, u16 op_code, u32 op_addr,
> +			    u32 *param, u32 param_len)
> +{
> +	struct aml_tci_rsp *rsp = NULL;
> +	struct sk_buff *skb = NULL;
> +	u32 buf_len = 0;

size_t?

> +	u8 *buf = NULL;
> +	int err = 0;
> +
> +	buf_len = sizeof(op_addr) + param_len;
> +	buf = kmalloc(buf_len, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	memcpy(buf, &op_addr, sizeof(op_addr));
> +	if (param && param_len > 0)
> +		memcpy(buf + sizeof(op_addr), param, param_len);
> +
> +	skb = __hci_cmd_sync_ev(hdev, op_code, buf_len, buf,
> +				HCI_EV_CMD_COMPLETE, HCI_INIT_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		err = PTR_ERR(skb);
> +		bt_dev_err(hdev, "Failed to send TCI cmd:(%d)", err);
> +		goto exit;
> +	}
> +
> +	rsp = skb_pull_data(skb, sizeof(struct aml_tci_rsp));
> +	if (!rsp)
> +		goto skb_free;
> +
> +	if (rsp->opcode != op_code || rsp->status != 0x00) {
> +		bt_dev_err(hdev, "send TCI cmd(0x%04X), response(0x%04X):(%d)",
> +		       op_code, rsp->opcode, rsp->status);
> +		err = -EINVAL;
> +		goto skb_free;
> +	}
> +
> +skb_free:
> +	kfree_skb(skb);
> +
> +exit:
> +	kfree(buf);
> +	return err;
> +}
> +
> +static int aml_update_chip_baudrate(struct hci_dev *hdev, u32 baud)
> +{
> +	u32 value;
> +
> +	value = ((AML_UART_CLK_SOURCE / baud) - 1) & 0x0FFF;
> +	value |= AML_UART_XMIT_EN | AML_UART_RECV_EN | AML_UART_TIMEOUT_INT_EN;
> +
> +	return aml_send_tci_cmd(hdev, AML_TCI_CMD_UPDATE_BAUDRATE,
> +				  AML_OP_UART_MODE, &value, sizeof(value));
> +}
> +
> +static int aml_start_chip(struct hci_dev *hdev)
> +{
> +	u32 value = 0;
> +	int ret;
> +
> +	value = AML_MM_CTR_HARD_TRAS_EN;
> +	ret = aml_send_tci_cmd(hdev, AML_TCI_CMD_WRITE,
> +			       AML_OP_MEM_HARD_TRANS_EN,
> +			       &value, sizeof(value));
> +	if (ret)
> +		return ret;
> +
> +	/* controller hardware reset. */
> +	value = AML_CTR_CPU_RESET | AML_CTR_MAC_RESET | AML_CTR_PHY_RESET;
> +	ret = aml_send_tci_cmd(hdev, AML_TCI_CMD_HARDWARE_RESET,
> +			       AML_OP_HARDWARE_RST,
> +			       &value, sizeof(value));
> +	return ret;
> +}
> +
> +static int aml_send_firmware_segment(struct hci_dev *hdev,
> +				     u8 fw_type,
> +				     u8 *seg,
> +				     u32 seg_size,
> +				     u32 offset)
> +{
> +	u32 op_addr = 0;
> +
> +	if (fw_type == FW_ICCM)
> +		op_addr = AML_OP_ICCM_RAM_BASE  + offset;
> +	else if (fw_type == FW_DCCM)
> +		op_addr = AML_OP_DCCM_RAM_BASE + offset;
> +
> +	return aml_send_tci_cmd(hdev, AML_TCI_CMD_DOWNLOAD_BT_FW,
> +			     op_addr, (u32 *)seg, seg_size);
> +}
> +
> +static int aml_send_firmware(struct hci_dev *hdev, u8 fw_type,
> +			     u8 *fw, u32 fw_size, u32 offset)
> +{
> +	u32 seg_size = 0;
> +	u32 seg_off = 0;
> +
> +	if (fw_size > AML_FIRMWARE_MAX_SIZE) {
> +		bt_dev_err(hdev, "fw_size error, fw_size:%d, max_size: 512K",

I’d add a space after the colon. Maybe more presize:

Firmware size %d kB is larger than the maximum of 512 kB. Aborting.

> +		       fw_size);
> +		return -EINVAL;
> +	}
> +	while (fw_size > 0) {
> +		seg_size = (fw_size > AML_FIRMWARE_OPERATION_SIZE) ?
> +			   AML_FIRMWARE_OPERATION_SIZE : fw_size;
> +		if (aml_send_firmware_segment(hdev, fw_type, (fw + seg_off),
> +					      seg_size, offset)) {
> +			bt_dev_err(hdev, "Failed send firmware, type:%d, offset:0x%x",

I’d add spaces after the colons.

> +			       fw_type, offset);
> +			return -EINVAL;
> +		}
> +		seg_off += seg_size;
> +		fw_size -= seg_size;
> +		offset += seg_size;
> +	}
> +	return 0;
> +}
> +
> +static int aml_download_firmware(struct hci_dev *hdev, const char *fw_name)
> +{
> +	struct hci_uart *hu = hci_get_drvdata(hdev);
> +	struct aml_serdev *amldev = serdev_device_get_drvdata(hu->serdev);
> +	const struct firmware *firmware = NULL;
> +	struct aml_fw_len *fw_len = NULL;
> +	u8 *iccm_start = NULL, *dccm_start = NULL;
> +	u32 iccm_len, dccm_len;
> +	u32 value = 0;
> +	int ret = 0;
> +
> +	/* Enable firmware download event. */
> +	value = AML_EVT_EN;
> +	ret = aml_send_tci_cmd(hdev, AML_TCI_CMD_WRITE,
> +			       AML_OP_EVT_ENABLE,
> +			       &value, sizeof(value));
> +	if (ret)
> +		goto exit;
> +
> +	/* RAM power on */
> +	value = AML_RAM_POWER_ON;
> +	ret = aml_send_tci_cmd(hdev, AML_TCI_CMD_WRITE,
> +			       AML_OP_RAM_POWER_CTR,
> +			       &value, sizeof(value));
> +	if (ret)
> +		goto exit;
> +
> +	/* Check RAM power status */
> +	ret = aml_send_tci_cmd(hdev, AML_TCI_CMD_READ,
> +			       AML_OP_RAM_POWER_CTR, NULL, 0);
> +	if (ret)
> +		goto exit;
> +
> +	ret = request_firmware(&firmware, fw_name, &hdev->dev);
> +	if (ret < 0) {
> +		bt_dev_err(hdev, "Failed to load <%s>:(%d)", fw_name, ret);
> +		goto exit;
> +	}
> +
> +	fw_len = (struct aml_fw_len *)firmware->data;
> +
> +	/* Download ICCM */
> +	iccm_start = (u8 *)(firmware->data) + sizeof(struct aml_fw_len)
> +			+ amldev->aml_dev_data->iccm_offset;
> +	iccm_len = fw_len->iccm_len - amldev->aml_dev_data->iccm_offset;
> +	ret = aml_send_firmware(hdev, FW_ICCM, iccm_start, iccm_len,
> +				amldev->aml_dev_data->iccm_offset);
> +	if (ret) {
> +		bt_dev_err(hdev, "Failed to send FW_ICCM (%d)", ret);
> +		goto exit;
> +	}
> +
> +	/* Download DCCM */
> +	dccm_start = (u8 *)(firmware->data) + sizeof(struct aml_fw_len) + fw_len->iccm_len;
> +	dccm_len = fw_len->dccm_len;
> +	ret = aml_send_firmware(hdev, FW_DCCM, dccm_start, dccm_len,
> +				amldev->aml_dev_data->dccm_offset);
> +	if (ret) {
> +		bt_dev_err(hdev, "Failed to send FW_DCCM (%d)", ret);
> +		goto exit;
> +	}
> +
> +	/* Disable firmware download event. */

I’d remove the dot and the end.

> +	value = 0;
> +	ret = aml_send_tci_cmd(hdev, AML_TCI_CMD_WRITE,
> +			       AML_OP_EVT_ENABLE,
> +			       &value, sizeof(value));
> +	if (ret)
> +		goto exit;
> +
> +exit:
> +	if (firmware)
> +		release_firmware(firmware);
> +	return ret;
> +}
> +
> +static int aml_send_reset(struct hci_dev *hdev)
> +{
> +	struct sk_buff *skb;
> +	int err;
> +
> +	skb = __hci_cmd_sync_ev(hdev, HCI_OP_RESET, 0, NULL,
> +				HCI_EV_CMD_COMPLETE, HCI_INIT_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		err = PTR_ERR(skb);
> +		bt_dev_err(hdev, "Failed to send hci reset cmd(%d)", err);
> +		return err;
> +	}
> +
> +	kfree_skb(skb);
> +	return 0;
> +}
> +
> +static int aml_dump_fw_version(struct hci_dev *hdev)
> +{
> +	struct aml_tci_rsp *rsp = NULL;
> +	struct sk_buff *skb;
> +	u8 value[6] = {0};
> +	u8 *fw_ver = NULL;
> +	int err = 0;
> +
> +	skb = __hci_cmd_sync_ev(hdev, AML_BT_HCI_VENDOR_CMD, sizeof(value), value,
> +				HCI_EV_CMD_COMPLETE, HCI_INIT_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		err = PTR_ERR(skb);
> +		bt_dev_err(hdev, "Failed get fw version:(%d)", err);

1.  Failed *to* get …
2.  I’d add a space after the colon, but would remove the colon, and 
maybe do:

         Failed to get fw version (error: %d)

> +		return err;
> +	}
> +
> +	rsp = skb_pull_data(skb, sizeof(struct aml_tci_rsp));
> +	if (!rsp)
> +		goto exit;
> +
> +	if (rsp->opcode != AML_BT_HCI_VENDOR_CMD || rsp->status != 0x00) {
> +		bt_dev_err(hdev, "dump version, error response (0x%04X):(%d)",
> +		       rsp->opcode, rsp->status);
> +		err = -EINVAL;
> +		goto exit;
> +	}
> +
> +	fw_ver = (u8 *)rsp + AML_EVT_HEAD_SIZE;
> +	bt_dev_info(hdev, "fw_version: date = %02x.%02x, number = 0x%02x%02x",
> +		*(fw_ver + 1), *fw_ver, *(fw_ver + 3), *(fw_ver + 2));
> +
> +exit:
> +	kfree_skb(skb);
> +	return err;
> +}
> +
> +static int aml_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
> +{
> +	struct aml_tci_rsp *rsp = NULL;
> +	struct sk_buff *skb;
> +	int err = 0;
> +
> +	bt_dev_info(hdev, "set bdaddr (%pM)", bdaddr);
> +	skb = __hci_cmd_sync_ev(hdev, AML_BT_HCI_VENDOR_CMD,
> +				sizeof(bdaddr_t), bdaddr,
> +				HCI_EV_CMD_COMPLETE, HCI_INIT_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		err = PTR_ERR(skb);
> +		bt_dev_err(hdev, "Failed to set bdaddr:(%d)", err);
> +		return err;
> +	}
> +
> +	rsp = skb_pull_data(skb, sizeof(struct aml_tci_rsp));
> +	if (!rsp)
> +		goto exit;
> +
> +	if (rsp->opcode != AML_BT_HCI_VENDOR_CMD || rsp->status != 0x00) {
> +		bt_dev_err(hdev, "error response (0x%x):(%d)", rsp->opcode, rsp->status);
> +		err = -EINVAL;
> +		goto exit;
> +	}
> +
> +exit:
> +	kfree_skb(skb);
> +	return err;
> +}
> +
> +static int aml_check_bdaddr(struct hci_dev *hdev)
> +{
> +	struct hci_rp_read_bd_addr *paddr;
> +	struct sk_buff *skb;
> +	int err;
> +
> +	if (bacmp(&hdev->public_addr, BDADDR_ANY))
> +		return 0;
> +
> +	skb = __hci_cmd_sync(hdev, HCI_OP_READ_BD_ADDR, 0, NULL,
> +			     HCI_INIT_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		err = PTR_ERR(skb);
> +		bt_dev_err(hdev, "Failed to read bdaddr:(%d)", err);
> +		return err;
> +	}
> +
> +	paddr = skb_pull_data(skb, sizeof(struct hci_rp_read_bd_addr));
> +	if (!paddr)
> +		goto exit;
> +
> +	if (!bacmp(&paddr->bdaddr, AML_BDADDR_DEFAULT)) {
> +		bt_dev_info(hdev, "amlbt using default bdaddr (%pM)", &paddr->bdaddr);
> +		set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
> +	}
> +
> +exit:
> +	kfree_skb(skb);
> +	return 0;
> +}
> +
> +static int aml_config_rf(struct hci_dev *hdev, bool is_coex)
> +{
> +	u32 value = AML_RF_ANT_DOUBLE;
> +
> +	/* Use a single antenna when co-existing with wifi. */
> +	if (is_coex)
> +		value = AML_RF_ANT_SINGLE;
> +
> +	return aml_send_tci_cmd(hdev, AML_TCI_CMD_WRITE,
> +				AML_OP_RF_CFG,
> +				&value, sizeof(value));
> +}
> +
> +static int aml_parse_dt(struct aml_serdev *amldev)
> +{
> +	struct device *pdev = amldev->dev;
> +
> +	amldev->bt_en_gpio = devm_gpiod_get(pdev, "enable",
> +					GPIOD_OUT_LOW);
> +	if (IS_ERR(amldev->bt_en_gpio)) {
> +		dev_err(pdev, "Failed to acquire enable gpios");
> +		return PTR_ERR(amldev->bt_en_gpio);
> +	}
> +
> +	if (device_property_read_string(pdev, "firmware-name",
> +					&amldev->firmware_name)) {
> +		dev_err(pdev, "Failed to acquire firmware path");
> +		return -ENODEV;
> +	}
> +
> +	amldev->bt_supply = devm_regulator_get(pdev, "vddio");
> +	if (IS_ERR(amldev->bt_supply)) {
> +		dev_err(pdev, "Failed to acquire regulator");
> +		return PTR_ERR(amldev->bt_supply);
> +	}
> +
> +	amldev->lpo_clk = devm_clk_get(pdev, NULL);
> +	if (IS_ERR(amldev->lpo_clk)) {
> +		dev_err(pdev, "Failed to acquire clock source");
> +		return PTR_ERR(amldev->lpo_clk);
> +	}
> +
> +	return 0;
> +}
> +
> +static int aml_power_on(struct aml_serdev *amldev)
> +{
> +	int err;
> +
> +	err = regulator_enable(amldev->bt_supply);
> +	if (err) {
> +		dev_err(amldev->dev, "Failed to enable regulator: (%d)", err);
> +		return err;
> +	}
> +
> +	err = clk_prepare_enable(amldev->lpo_clk);
> +	if (err) {
> +		dev_err(amldev->dev, "Failed to enable lpo clock: (%d)", err);
> +		return err;
> +	}
> +
> +	gpiod_set_value_cansleep(amldev->bt_en_gpio, 1);
> +
> +	/* wait 100ms for bluetooth controller power on  */
> +	msleep(100);
> +	return 0;
> +}
> +
> +static int aml_power_off(struct aml_serdev *amldev)
> +{
> +	gpiod_set_value_cansleep(amldev->bt_en_gpio, 0);
> +
> +	clk_disable_unprepare(amldev->lpo_clk);
> +
> +	regulator_disable(amldev->bt_supply);
> +
> +	return 0;
> +}
> +
> +static int aml_set_baudrate(struct hci_uart *hu, unsigned int speed)
> +{
> +	/* update controller baudrate*/
> +	if (aml_update_chip_baudrate(hu->hdev, speed) != 0) {
> +		bt_dev_err(hu->hdev, "Failed to update baud rate");
> +		return -EINVAL;
> +	}
> +
> +	/* update local baudrate*/
> +	serdev_device_set_baudrate(hu->serdev, speed);
> +
> +	return 0;
> +}
> +
> +/* Initialize protocol */
> +static int aml_open(struct hci_uart *hu)
> +{
> +	struct aml_serdev *amldev = serdev_device_get_drvdata(hu->serdev);
> +	struct aml_data *aml_data;
> +	int err;
> +
> +	err = aml_parse_dt(amldev);
> +	if (err)
> +		return err;
> +
> +	if (!hci_uart_has_flow_control(hu)) {
> +		bt_dev_err(hu->hdev, "no flow control");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	aml_data = kzalloc(sizeof(*aml_data), GFP_KERNEL);
> +	if (!aml_data)
> +		return -ENOMEM;
> +
> +	skb_queue_head_init(&aml_data->txq);
> +
> +	hu->priv = aml_data;
> +
> +	return 0;
> +}
> +
> +static int aml_close(struct hci_uart *hu)
> +{
> +	struct aml_serdev *amldev = serdev_device_get_drvdata(hu->serdev);
> +	struct aml_data *aml_data = hu->priv;
> +
> +	if (hu->serdev)
> +		serdev_device_close(hu->serdev);
> +
> +	skb_queue_purge(&aml_data->txq);
> +	kfree_skb(aml_data->rx_skb);
> +	kfree(aml_data);
> +
> +	hu->priv = NULL;
> +
> +	return aml_power_off(amldev);
> +}
> +
> +static int aml_flush(struct hci_uart *hu)
> +{
> +	struct aml_data *aml_data = hu->priv;
> +
> +	skb_queue_purge(&aml_data->txq);
> +
> +	return 0;
> +}
> +
> +static int aml_setup(struct hci_uart *hu)
> +{
> +	struct aml_serdev *amldev = serdev_device_get_drvdata(hu->serdev);
> +	struct hci_dev *hdev = amldev->serdev_hu.hdev;
> +	int err;
> +
> +	/* Setup bdaddr */
> +	hdev->set_bdaddr = aml_set_bdaddr;
> +
> +	err = aml_power_on(amldev);
> +	if (err)
> +		return err;
> +
> +	err = aml_set_baudrate(hu, amldev->serdev_hu.proto->oper_speed);
> +	if (err)
> +		return err;
> +
> +	err = aml_download_firmware(hdev, amldev->firmware_name);
> +	if (err)
> +		return err;
> +
> +	err = aml_config_rf(hdev, amldev->aml_dev_data->is_coex);
> +	if (err)
> +		return err;
> +
> +	err = aml_start_chip(hdev);
> +	if (err)
> +		return err;
> +
> +	/* wait 350ms for controller start up*/

Missing space at the end.

Also, why 350 ms? That is pretty long.

> +	msleep(350);
> +
> +	err = aml_dump_fw_version(hdev);
> +	if (err)
> +		return err;
> +
> +	err = aml_send_reset(hdev);
> +	if (err)
> +		return err;
> +
> +	err = aml_check_bdaddr(hdev);
> +	if (err)
> +		return err;
> +
> +	return 0;
> +}

[…]


Kind regards,

Paul

