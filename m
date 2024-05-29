Return-Path: <netdev+bounces-98965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8808D33FC
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 12:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 331ED1C23521
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 10:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B08017A902;
	Wed, 29 May 2024 10:06:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4CF31A60;
	Wed, 29 May 2024 10:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716977187; cv=none; b=jExvA05/sTJWKShe426qj6C9+QZ2O0x+eZZgYmKauFCg2/O36antdn/+AO5UTjJr7pK3mnfkQBT0hBhCqSmbJmNTM7MAuqRfQMOKHVYhcy2Z53IPuqQATgo7jN+c/REXj5dOaTEYCpK/iSsvF10MEBT0v8n2v7j2gN8Qcmo0/GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716977187; c=relaxed/simple;
	bh=G1Rk+7kEkFD09wELNnRj53zJwtqDGrgnZU8T7fnfjek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KLQdI1tLIJE2JQiMec2wxw0VHutBTF3Yh0jmsoMNqKamK72U+/K2orPm5/A25o4QXcSg/oHCBvjy1FxIPcH23lUD8De6EtNboIidZmkskBwQ1zroQ7uXc5TADuI/9SkFFH58Zw4ciivK1YrS9/jw42UxVhpLgSygWFo/ciX+jG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.3] (ip5f5af7f7.dynamic.kabel-deutschland.de [95.90.247.247])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id ABB5461E5FE01;
	Wed, 29 May 2024 12:05:43 +0200 (CEST)
Message-ID: <52ccf0c1-e5dd-412b-9e47-7829ca0f6ffc@molgen.mpg.de>
Date: Wed, 29 May 2024 12:05:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] Bluetooth: btnxpuart: Update firmware names
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, amitkumar.karwar@nxp.com, rohit.fule@nxp.com,
 sherry.sun@nxp.com, ziniu.wang_1@nxp.com, haibo.chen@nxp.com,
 LnxRevLi@nxp.com, regressions@lists.linux.dev
References: <20240529095347.22186-1-neeraj.sanjaykale@nxp.com>
 <20240529095347.22186-3-neeraj.sanjaykale@nxp.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240529095347.22186-3-neeraj.sanjaykale@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

[Cc: regressions@]

Dear Neeraj,


Am 29.05.24 um 11:53 schrieb Neeraj Sanjay Kale:
> This updates the firmware names of 3 chipsets: w8987, w8997, w9098.
> These changes are been done to standardize chip specific firmware
> file names.

Can you please describe the new naming schema in the commit message?

> To allow user to use older firmware file names, a new device tree
> property has been introduced called firmware-name, which will override
> the hardcoded firmware names in the driver.

So users updating the Linux kernel but not updating the devicetree with 
the new property are going to see a regression, right? I think this 
violates Linux’ no regression policy. If so, please implement a way to 
support old and new names.

> Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> ---
> v2: Remove "nxp/" from all firmware name definitions to be inline with
> firware file name read from device tree file. (Krzysztof)

fir*m*ware

> ---
>   drivers/bluetooth/btnxpuart.c | 28 +++++++++++++++++-----------
>   1 file changed, 17 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
> index 0b93c2ff29e4..4442d911eba8 100644
> --- a/drivers/bluetooth/btnxpuart.c
> +++ b/drivers/bluetooth/btnxpuart.c
> @@ -33,16 +33,16 @@
>   /* NXP HW err codes */
>   #define BTNXPUART_IR_HW_ERR		0xb0
>   
> -#define FIRMWARE_W8987		"nxp/uartuart8987_bt.bin"
> -#define FIRMWARE_W8997		"nxp/uartuart8997_bt_v4.bin"
> -#define FIRMWARE_W9098		"nxp/uartuart9098_bt_v1.bin"
> -#define FIRMWARE_IW416		"nxp/uartiw416_bt_v0.bin"
> -#define FIRMWARE_IW612		"nxp/uartspi_n61x_v1.bin.se"
> -#define FIRMWARE_IW624		"nxp/uartiw624_bt.bin"
> -#define FIRMWARE_SECURE_IW624	"nxp/uartiw624_bt.bin.se"
> -#define FIRMWARE_AW693		"nxp/uartaw693_bt.bin"
> -#define FIRMWARE_SECURE_AW693	"nxp/uartaw693_bt.bin.se"
> -#define FIRMWARE_HELPER		"nxp/helper_uart_3000000.bin"
> +#define FIRMWARE_W8987		"uart8987_bt_v0.bin"
> +#define FIRMWARE_W8997		"uart8997_bt_v4.bin"
> +#define FIRMWARE_W9098		"uart9098_bt_v1.bin"
> +#define FIRMWARE_IW416		"uartiw416_bt_v0.bin"
> +#define FIRMWARE_IW612		"uartspi_n61x_v1.bin.se"
> +#define FIRMWARE_IW624		"uartiw624_bt.bin"
> +#define FIRMWARE_SECURE_IW624	"uartiw624_bt.bin.se"
> +#define FIRMWARE_AW693		"uartaw693_bt.bin"
> +#define FIRMWARE_SECURE_AW693	"uartaw693_bt.bin.se"
> +#define FIRMWARE_HELPER		"helper_uart_3000000.bin"
>   
>   #define CHIP_ID_W9098		0x5c03
>   #define CHIP_ID_IW416		0x7201
> @@ -685,13 +685,19 @@ static bool process_boot_signature(struct btnxpuart_dev *nxpdev)
>   static int nxp_request_firmware(struct hci_dev *hdev, const char *fw_name)
>   {
>   	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
> +	const char *fw_name_dt;
>   	int err = 0;
>   
>   	if (!fw_name)
>   		return -ENOENT;
>   
>   	if (!strlen(nxpdev->fw_name)) {
> -		snprintf(nxpdev->fw_name, MAX_FW_FILE_NAME_LEN, "%s", fw_name);
> +		if (strcmp(fw_name, FIRMWARE_HELPER) &&
> +		    !device_property_read_string(&nxpdev->serdev->dev,
> +						 "firmware-name",
> +						 &fw_name_dt))
> +			fw_name = fw_name_dt;
> +		snprintf(nxpdev->fw_name, MAX_FW_FILE_NAME_LEN, "nxp/%s", fw_name);
>   
>   		bt_dev_dbg(hdev, "Request Firmware: %s", nxpdev->fw_name);
>   		err = request_firmware(&nxpdev->fw, nxpdev->fw_name, &hdev->dev);


Kind regards,

Paul

