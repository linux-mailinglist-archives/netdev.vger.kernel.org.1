Return-Path: <netdev+bounces-218090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1B9B3B0C4
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 04:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 542C61C22BD4
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 02:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46BA219A67;
	Fri, 29 Aug 2025 02:13:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B926202980;
	Fri, 29 Aug 2025 02:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756433600; cv=none; b=j08qjoNhpI9J46GwApCC79vxUZFMoBagHT2U4QkFcSg46PNK7LiNAVqEvHx0VJXYuStCoAtpVT8J1r9t7e7pwxGTMwO5JjKZP0Y9Zg2R03BFmqVqk3NHga4D/I/PCWE2zQtqwVAkYDGZzmJFz4iPw4gcHHTKfaU8rhCsl5g+87k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756433600; c=relaxed/simple;
	bh=bn36VH6fLv38tAROLVseb78fk0ahQrjwo5qQOr7SelU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zil6krD0vn2o1lSDHM7LEzewH99mdYVyaAxa/VqKCxEzVOTbgX96oDDlpfjkS8qPVgzzriZ8SxzdFa8ItKvJlzC987vF5b8oefzQU0tJhooLWrqCSKgdfOFpqKx5mk/m9UCmmPrzxQ8Csdn2eWJN7FVsY6RS1GSMkDT0L2VCKy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpgz4t1756433576t23706f55
X-QQ-Originating-IP: p046whFzyUY8taJB0Gc2SR98nVSkqVtDSMRR9p6MXGA=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 29 Aug 2025 10:12:54 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8592654146579979855
Date: Fri, 29 Aug 2025 10:12:54 +0800
From: Yibo Dong <dong100@mucse.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com, kees@kernel.org,
	gustavoars@kernel.org, rdunlap@infradead.org,
	vadim.fedorenko@linux.dev, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v9 4/5] net: rnpgbe: Add basic mbx_fw support
Message-ID: <DB12A33105BC0233+20250829021254.GA904254@nic-Precision-5820-Tower>
References: <20250828025547.568563-1-dong100@mucse.com>
 <20250828025547.568563-5-dong100@mucse.com>
 <d61dd41c-5700-483f-847a-a92000b8a925@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d61dd41c-5700-483f-847a-a92000b8a925@lunn.ch>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OAj1qrjhA85Aij9gO9YcsnUCJUqHISXM9E4WgsZcAV3J71kpptWBA0nY
	muP4H9klQqERQIoPhB4RnxnnqyPU8QshvwZHk6jQ14w9Pv8lCYbZlrrcl2hp74KQ63jh0GD
	2k3InfEJ25UOA+8xNJh+iUKf8z/MaueAqE767dSqQ5wd70BAj9iNhxnadeRWS0icka0GGPK
	B+j/5POyDAmoJtEQP9Jt/qAOoO4Ays3MbWmmR8kKRbgVNaoCDOahaF70+47chdQCnkXEz3j
	9enGWaWBICC5wjNn7bj2YRGnKLR2HGiDM3BQ+a6F8UAfQjF3F5xiPtoSJJf/vIqrcxFMla9
	EzbUQwR7Px5mPwI+siPMD9a2loL9kVYVJMMfVoHtT24dPV60cM39hbV2RyVdapgcb16i+Cl
	mhsxlFY49nd72uSdlYHuCdxJ+pTpt5gsedtpb6PB5r62cXhj8j3velDR218K4BogipsfFiw
	gbqFSKShKuPFBch3f2SlAqqzjwA3Zrmy4U/m1IRbzswo8oJzLf0zLIbL2nZgFogouVVwqw8
	2Sy6TzRiYx3ESnteCqIo+52YI/B2L3XRV2xZu4ZxySy6heUnCMmzqed/kSmLhKL6jYVElok
	AHWMhdp92aAW2tP8dYmJVpRpzVu7mRDFlbK0sMgBney+1k1wDPiy8gkBgk9hT8DXsP8R/cO
	XH5A7HY+OTmIqT+S9aNFg8IP5ONk4Yf+JhiwnfQ1zGMVc0eDJj/hPAxYZpGWGbFKsHF+efL
	xdMpomW17Z5it5itkkcc0UWOlNCyrTrnuHbvWDrCroH2hxaIMvyS0oige2qDCr7Ih4wg/Xy
	SY5CbSs6/DdFL8UQ7bxfzjlOtyiPUhZ6wbmt0Va8SdbLLq53gbOZyWw/19vSxi73a85bZw/
	PaTUiZRZYsqVFk62KJqf69CWZHeEKOiLV+x1z5LMWNVWqVYeSsR/vVzq8nsmgKmEzy7dt0I
	vIALI7tlGROqGemkokqscGDmzM6lXgdVm7kOmH8P5FYfgwdynyijppHs2
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

On Thu, Aug 28, 2025 at 03:09:51PM +0200, Andrew Lunn wrote:
> > +/**
> > + * mucse_mbx_get_capability - Get hw abilities from fw
> > + * @hw: pointer to the HW structure
> > + *
> > + * mucse_mbx_get_capability tries to get capabities from
> > + * hw. Many retrys will do if it is failed.
> > + *
> > + * Return: 0 on success, negative errno on failure
> > + **/
> > +int mucse_mbx_get_capability(struct mucse_hw *hw)
> > +{
> > +	struct hw_abilities ability = {};
> > +	int try_cnt = 3;
> > +	int err;
> > +	/* It is called once in probe, if failed nothing
> > +	 * (register network) todo. Try more times to get driver
> > +	 * and firmware in sync.
> > +	 */
> > +	do {
> > +		err = mucse_fw_get_capability(hw, &ability);
> > +		if (err)
> > +			continue;
> > +		break;
> > +	} while (try_cnt--);
> > +
> > +	if (!err)
> > +		hw->pfvfnum = le16_to_cpu(ability.pfnum) & GENMASK_U16(7, 0);
> > +	return err;
> > +}
> 
> I still think this should be a dedicated function to get the MAC
> driver and firmware in sync, using a NOP or version request to the
> firmware. The name mucse_mbx_get_capability() does not indicate this
> function is special in any way, which is it.
> 

Maybe I should rename it like this?

/**
 * mucse_mbx_sync_fw_by_get_capability - Try to sync driver and fw
 * @hw: pointer to the HW structure
 *
 * mucse_mbx_sync_fw_by_get_capability tries to sync driver and fw
 * by get capabitiy mbx cmd. Many retrys will do if it is failed.
 *
 * Return: 0 on success, negative errno on failure
 **/
int mucse_mbx_sync_fw_by_get_capability(struct mucse_hw *hw)
{
	struct hw_abilities ability = {};
	int try_cnt = 3;
	int err;
	/* It is called once in probe, if failed nothing
	 * (register network) todo. Try more times to get driver
	 * and firmware in sync.
	 */
	do {
		err = mucse_fw_get_capability(hw, &ability);
		if (err)
			continue;
		break;
	} while (try_cnt--);

	if (!err)
		hw->pfvfnum = le16_to_cpu(ability.pfnum) & GENMASK_U16(7, 0);
	return err;
}

> > +/**
> > + * build_ifinsmod - build req with insmod opcode
> > + * @req: pointer to the cmd req structure
> > + * @is_insmod: true for insmod, false for rmmod
> > + **/
> > +static void build_ifinsmod(struct mbx_fw_cmd_req *req,
> > +			   bool is_insmod)
> > +{
> > +	req->flags = 0;
> > +	req->opcode = cpu_to_le16(DRIVER_INSMOD);
> > +	req->datalen = cpu_to_le16(sizeof(req->ifinsmod) +
> > +				   MBX_REQ_HDR_LEN);
> > +	req->reply_lo = 0;
> > +	req->reply_hi = 0;
> > +#define FIXED_VERSION 0xFFFFFFFF
> > +	req->ifinsmod.version = cpu_to_le32(FIXED_VERSION);
> > +	if (is_insmod)
> > +		req->ifinsmod.status = cpu_to_le32(1);
> > +	else
> > +		req->ifinsmod.status = cpu_to_le32(0);
> > +}
> 
> Why does the firmware care? What does the firmware do when there is no
> kernel driver? How does it behaviour change when the driver loads?
> 

fw reduce working frequency to save power if no driver is probed to this
chip. And fw change frequency to normal after recieve insmod mbx cmd.

Maybe I should add the comment to func "mucse_mbx_ifinsmod"? 
/**
 * mucse_mbx_ifinsmod - Echo driver insmod status to fw
 * @hw: pointer to the HW structure
 * @is_insmod: true for insmod, false for rmmod
 *
 * mucse_mbx_ifinsmod echo driver insmod status to fw. fw changes working
 * frequency to normal after recieve insmod status, and reduce working
 * frequency if no driver is probed.
 *
 * Return: 0 on success, negative errno on failure
 **/
int mucse_mbx_ifinsmod(struct mucse_hw *hw, bool is_insmod)
{


}

> Please try to ensure comment say why you are doing something, not what
> you are doing.
> 
> 
>     Andrew
> 
> ---
> pw-bot: cr
> 

Thanks for your feedback.


