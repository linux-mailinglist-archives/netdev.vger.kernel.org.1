Return-Path: <netdev+bounces-204493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13971AFAE59
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 10:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 581CF3A5855
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 08:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B70E1C5F14;
	Mon,  7 Jul 2025 08:15:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.77.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75172CCC8;
	Mon,  7 Jul 2025 08:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.77.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751876158; cv=none; b=Kuxtvx6HSYBDvF8EwwKHE9npNQp42TCdvCoqUzxF4NTTPX7rm21u72SwXylsAkaR4ZLkSJus0hDGYmtZEbibOTP9GE4t6RXztJNh6Ec+UkLQ2iiHVUncbUH/XzCldVllQ8JUAXGvPXsQwoGnsdZQm3TMttoNazEdCBDQKbTgdSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751876158; c=relaxed/simple;
	bh=Dd9Xk6xGGd0ME7zXV2jEaLbAC4FI8QKMO0ycCC1LHgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pGxGEE4W24Ex4WyRj2ec7FuNE/N++cEW3lhcgNj2nPPQ6L1DDLGzUvUMsTLV37Oj8n4795CFhijuamSY76Ct+fAROHXgcFpDThoxzolsd3LchwzyI+DKjpWruRuuSCWl3r2iJH6yyp3cF456SgJx7tRaS1S6SOTGnCWr0gBaYyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=114.132.77.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz21t1751876057t3b8668fe
X-QQ-Originating-IP: vPFkWzDcFDHcvaKiIAy0Ih4IzObjBkvW/Dpqgv0ZlPo=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 07 Jul 2025 16:14:15 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13134278031464448130
Date: Mon, 7 Jul 2025 16:14:14 +0800
From: Yibo Dong <dong100@mucse.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
	andrew+netdev@lunn.ch, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/15] net: rnpgbe: Add download firmware for n210 chip
Message-ID: <0FA3F272A6C59EFF+20250707081414.GA166175@nic-Precision-5820-Tower>
References: <20250703014859.210110-1-dong100@mucse.com>
 <20250703014859.210110-6-dong100@mucse.com>
 <37ede55f-613b-481f-a8d9-43ee1414849a@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37ede55f-613b-481f-a8d9-43ee1414849a@lunn.ch>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: Nj/O81qLKo2gDJk6/WQnhlZCV2blhLEjBNLp90yvs9tYHea82L5evEyl
	qlLsenyPYn22vmYk6t6xCVLxNqZO+5HpvtvYhl//TpWfAf9B9/7KWBw8JACJV4uRlsZo1QU
	r6ul2OC8j0dY7hDzEx+pePRHGAn9lO5uoRljzH5+k/w7h1MkFudqVgo2T0e9l6s3N1CuM6f
	BT098Ch0tps+pPP4whjXT8shMKeBAkQu2t7/A+26d8N1HaELeJzU2gew8P/p3D+re5moDf/
	KbDhNoRaN5E2R7+OxTvC7/gY+jarvUodKF5a7jLyDBO6SJejYiphNZdbaHFkX9yRuHxWUZ9
	nhDomtUAaYQneV46721gMqatKoI617lmlyWesPl2s0CRZL9pCdgjOKEVUUpULTU7/oiUEVa
	ihHpTxgOTzNEJ+HLuw2md1okRSaQs9nf3q0b6ehPD9uf3l9kEbLcHb68/lyDOzlPjJVHkS0
	pMIGMDfQeFCGvK/6XwxPwdW9Ssha+ZXp4aoao8q9RMufno73Mw8Bbup3vJCpzGNILiDkq9p
	BgGR81hdqSk9AV34+kNULpPHwoaKvmtEovzglMhI8PXgDMrWX4ouXY+jryBy3AruUzXqrNE
	IQb3vX4edI6lKCcQ8ZePVLTXSyTqifmAZ9JCFKxXRH/ci6KYFi6FJx9l9DVJEcUBwyayXIf
	ecwb6/i0G1F0igp2GW4jclrL0KgS7yP1dzcbO2XTGeIKijnBX/ir4AYJodsyyt7rrR/B1c7
	u8LON5/0COcr7aapkj3vidhfxHYmJa7eRvprfVzyZXA2sKHwc897Z8cIsdqOUWRf36fjju4
	jHPUzppgtuUHXKL3K9gByNZvePKvkAvGp4oTxgdEJYwQBUUcwcRHLEXSE4JdqDrdyI3HeyS
	aVCn6SAYKSi7lrpPUAaeHwWGvSsMD0AAYK9Xm3cHAnHLE9C3S7gRnvNYMkCFr+1KFOspbiN
	N8ux6UN12ZG1Hlw+dapiwTd3g9ek8glnNRpC+sQRmpY59HN05KzB5VnRhnIiOyDNwSHDUZM
	xCkxdqPA==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

On Fri, Jul 04, 2025 at 08:33:14PM +0200, Andrew Lunn wrote:
> >  static int init_firmware_for_n210(struct mucse_hw *hw)
> >  {
> > -	return 0;
> > +	char *filename = "n210_driver_update.bin";
> > +	const struct firmware *fw;
> > +	struct pci_dev *pdev = hw->pdev;
> > +	int rc = 0;
> > +	int err = 0;
> > +	struct mucse *mucse = (struct mucse *)hw->back;
> > +
> > +	rc = request_firmware(&fw, filename, &pdev->dev);
> > +
> > +	if (rc != 0) {
> > +		dev_err(&pdev->dev, "requesting firmware file failed\n");
> > +		return rc;
> > +	}
> > +
> > +	if (rnpgbe_check_fw_from_flash(hw, fw->data)) {
> > +		dev_info(&pdev->dev, "firmware type error\n");
> 
> Why dev_info()? If this is an error then you should use dev_err().
> 
Yes, it should be dev_err().
> > +	dev_info(&pdev->dev, "init firmware successfully.");
> > +	dev_info(&pdev->dev, "Please reboot.");
> 
> Don't spam the lock with status messages.
> 
> Reboot? Humm, maybe this should be devlink flash command.
> 
> request_firmware() is normally used for download into SRAM which is
> then used immediately. If you need to reboot the machine, devlink is
> more appropriate.
> 
Yes, this is used to download flash to the chip, and then reboot to run.
I will change it to devlink.
> > +static inline void mucse_sfc_command(u8 __iomem *hw_addr, u32 cmd)
> > +{
> > +	iowrite32(cmd, (hw_addr + 0x8));
> > +	iowrite32(1, (hw_addr + 0x0));
> > +	while (ioread32(hw_addr) != 0)
> > +		;
> 
> 
> Never do endless loops waiting for hardware. It might never give what
> you want, and there is no escape.
> 
Got it, I will update this.
> > +static int32_t mucse_sfc_flash_wait_idle(u8 __iomem *hw_addr)
> > +{
> > +	int time = 0;
> > +	int ret = HAL_OK;
> > +
> > +	iowrite32(CMD_CYCLE(8), (hw_addr + 0x10));
> > +	iowrite32(RD_DATA_CYCLE(8), (hw_addr + 0x14));
> > +
> > +	while (1) {
> > +		mucse_sfc_command(hw_addr, CMD_READ_STATUS);
> > +		if ((ioread32(hw_addr + 0x4) & 0x1) == 0)
> > +			break;
> > +		time++;
> > +		if (time > 1000)
> > +			ret = HAL_FAIL;
> > +	}
> 
> iopoll.h 
> 
Got it, I will use method in iopoll.h.
> > +static int mucse_sfc_flash_erase_sector(u8 __iomem *hw_addr,
> > +					u32 address)
> > +{
> > +	int ret = HAL_OK;
> > +
> > +	if (address >= RSP_FLASH_HIGH_16M_OFFSET)
> > +		return HAL_EINVAL;
> 
> Use linux error codes, EINVAL.
> 
Got it.
> > +
> > +	if (address % 4096)
> > +		return HAL_EINVAL;
> 
> EINVAL
> 
Got it.
> > +
> > +	mucse_sfc_flash_write_enable(hw_addr);
> > +
> > +	iowrite32((CMD_CYCLE(8) | ADDR_CYCLE(24)), (hw_addr + 0x10));
> > +	iowrite32((RD_DATA_CYCLE(0) | WR_DATA_CYCLE(0)), (hw_addr + 0x14));
> > +	iowrite32(SFCADDR(address), (hw_addr + 0xc));
> > +	mucse_sfc_command(hw_addr, CMD_SECTOR_ERASE);
> > +	if (mucse_sfc_flash_wait_idle(hw_addr)) {
> > +		ret = HAL_FAIL;
> > +		goto failed;
> 
> mucse_sfc_flash_wait_idle() should return -ETIMEDOUT, so return that.
> 
> 	Andrew
> 
Got it, I will return -ETIMEDOUT.
Thanks for your feedback.

