Return-Path: <netdev+bounces-182654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F931A89818
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 11:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E099E1894F40
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 09:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F80727FD6B;
	Tue, 15 Apr 2025 09:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="r1K1693H"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FC22DFA25;
	Tue, 15 Apr 2025 09:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744709895; cv=none; b=kJ50x1s68Gigv0q8OyB423/LOYXfL8aMeHqn4p8q0knYvjhMuz6tTy+PE6YxtM3A5md3WbdufdINvLDQWKULe0tFKJkyyS6eAsYUCoRGaOW96SLRejEY74lemkKRkVRVOHqQHUKQADGAUYzPvMzlF7ZeS/VF891VNBo2PjAPHrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744709895; c=relaxed/simple;
	bh=xaKHJsfs6nDATUx2MH5SuPS0TmTLbKrzGTS6XpSqG8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bfMHUze/zHtg99pvsPAubU7IzU43TEEBN3ANpGr278ewVVDKUqnye4wzDpwD+XltfBlaE9P2Uz7+PCYKbeGAje017LI1c+mRzSP84d53+uKg+vlRJGz6IC5fQ59GH7+xhH5igwQLUmX/oVRgW5bOQlDuSmGbhXYa7e3fX6Yg6ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=r1K1693H; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=OUv7GPstaYvfaSEXD1p7wo00AwrEb1fxvB3QnVCrHGw=; b=r1K1693HPgufRTVCkWEGhRIU0M
	SVqG8LtVLO8RdI7fHYcV+rD+4uPY9/wlUmKuGM1CzWANwVxiTC3y9hYnw3F8QT6VetuDW+gqHgH9+
	Vx4csp1GDasgfRzSBGIBfsBpWfAhcBNyoo008jVn5gkp21eGLhMhobAjtvjP2UvPp6SADriGR0Tqo
	KqBqMHyWoknySNIeuL8NN6LVx1nIdufGpTL9J1myrpAC/CNcs00Lw1aRFDQMw8EkVPSzqL50obhfl
	KcUiLXjjM0TkBpLpcjlwDvMtLjfgNjLGZzHIRq+fSQ5eccScLvFiABhBuail28KKlR/rk3GqGtFU9
	TK9vHRKw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58620)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u4cjr-0007rA-0B;
	Tue, 15 Apr 2025 10:37:55 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u4cjl-0000FC-0l;
	Tue, 15 Apr 2025 10:37:49 +0100
Date: Tue, 15 Apr 2025 10:37:49 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Andrei Botila <andrei.botila@oss.nxp.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Eric Woudstra <ericwouds@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.or
Subject: Re: [net-next PATCH v7 5/6] net: phy: Add support for Aeonsemi
 AS21xxx PHYs
Message-ID: <Z_4o7SBGxHBdjWFZ@shell.armlinux.org.uk>
References: <20250410095443.30848-1-ansuelsmth@gmail.com>
 <20250410095443.30848-6-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410095443.30848-6-ansuelsmth@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Apr 10, 2025 at 11:53:35AM +0200, Christian Marangi wrote:
> +#define VEND1_IPC_DATA0			0x5808
> +#define VEND1_IPC_DATA1			0x5809
> +#define VEND1_IPC_DATA2			0x580a
> +#define VEND1_IPC_DATA3			0x580b
> +#define VEND1_IPC_DATA4			0x580c
> +#define VEND1_IPC_DATA5			0x580d
> +#define VEND1_IPC_DATA6			0x580e
> +#define VEND1_IPC_DATA7			0x580f

Do you use any of these other than the first? If not, please remove
them, maybe adding a comment before the first stating that there are
8 registers.

> +static int aeon_ipcs_wait_cmd(struct phy_device *phydev, bool parity_status)
> +{
> +	u16 val;
> +
> +	/* Exit condition logic:
> +	 * - Wait for parity bit equal
> +	 * - Wait for status success, error OR ready
> +	 */
> +	return phy_read_mmd_poll_timeout(phydev, MDIO_MMD_VEND1, VEND1_IPC_STS, val,
> +					 FIELD_GET(AEON_IPC_STS_PARITY, val) == parity_status &&
> +					 (val & AEON_IPC_STS_STATUS) != AEON_IPC_STS_STATUS_RCVD &&
> +					 (val & AEON_IPC_STS_STATUS) != AEON_IPC_STS_STATUS_PROCESS &&
> +					 (val & AEON_IPC_STS_STATUS) != AEON_IPC_STS_STATUS_BUSY,
> +					 AEON_IPC_DELAY, AEON_IPC_TIMEOUT, false);

Hmm. I'm wondering whether:

static bool aeon_ipc_ready(u16 val, bool parity_status)
{
	u16 status;

	if (FIELD_GET(AEON_IPC_STS_PARITY, val) != parity_status)
		return false;

	status = val & AEON_IPC_STS_STATUS;

	return status != AEON_IPC_STS_STATUS_RCVD &&
	       status != AEON_IPC_STS_STATUS_PROCESS &&
	       status != AEON_IPC_STS_STATUS_BUSY;
}

would be better, and then maybe you can fit the code into less than 80
columns. I'm not a fan of FIELD_PREP_CONST() when it causes differing
usage patterns like the above (FIELD_GET(AEON_IPC_STS_STATUS, val)
would match the coding style, and probably makes no difference to the
code emitted.)

> +}
> +
> +static int aeon_ipc_send_cmd(struct phy_device *phydev,
> +			     struct as21xxx_priv *priv,
> +			     u16 cmd, u16 *ret_sts)
> +{
> +	bool curr_parity;
> +	int ret;
> +
> +	/* The IPC sync by using a single parity bit.
> +	 * Each CMD have alternately this bit set or clear
> +	 * to understand correct flow and packet order.
> +	 */
> +	curr_parity = priv->parity_status;
> +	if (priv->parity_status)
> +		cmd |= AEON_IPC_CMD_PARITY;
> +
> +	/* Always update parity for next packet */
> +	priv->parity_status = !priv->parity_status;
> +
> +	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_IPC_CMD, cmd);
> +	if (ret)
> +		return ret;
> +
> +	/* Wait for packet to be processed */
> +	usleep_range(AEON_IPC_DELAY, AEON_IPC_DELAY + 5000);
> +
> +	/* With no ret_sts, ignore waiting for packet completion
> +	 * (ipc parity bit sync)
> +	 */
> +	if (!ret_sts)
> +		return 0;
> +
> +	ret = aeon_ipcs_wait_cmd(phydev, curr_parity);
> +	if (ret)
> +		return ret;
> +
> +	ret = phy_read_mmd(phydev, MDIO_MMD_VEND1, VEND1_IPC_STS);
> +	if (ret < 0)
> +		return ret;
> +
> +	*ret_sts = ret;
> +	if ((*ret_sts & AEON_IPC_STS_STATUS) != AEON_IPC_STS_STATUS_SUCCESS)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int aeon_ipc_send_msg(struct phy_device *phydev,
> +			     u16 opcode, u16 *data, unsigned int data_len,
> +			     u16 *ret_sts)
> +{
> +	struct as21xxx_priv *priv = phydev->priv;
> +	u16 cmd;
> +	int ret;
> +	int i;
> +
> +	/* IPC have a max of 8 register to transfer data,
> +	 * make sure we never exceed this.
> +	 */
> +	if (data_len > AEON_IPC_DATA_MAX)
> +		return -EINVAL;
> +
> +	mutex_lock(&priv->ipc_lock);
> +
> +	for (i = 0; i < data_len / sizeof(u16); i++)
> +		phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_IPC_DATA(i),
> +			      data[i]);
> +
> +	cmd = FIELD_PREP(AEON_IPC_CMD_SIZE, data_len) |
> +	      FIELD_PREP(AEON_IPC_CMD_OPCODE, opcode);
> +	ret = aeon_ipc_send_cmd(phydev, priv, cmd, ret_sts);
> +	if (ret)
> +		phydev_err(phydev, "failed to send ipc msg for %x: %d\n",
> +			   opcode, ret);
> +
> +	mutex_unlock(&priv->ipc_lock);
> +
> +	return ret;
> +}
> +
> +static int aeon_ipc_rcv_msg(struct phy_device *phydev,
> +			    u16 ret_sts, u16 *data)
> +{
> +	struct as21xxx_priv *priv = phydev->priv;
> +	unsigned int size;
> +	int ret;
> +	int i;
> +
> +	if ((ret_sts & AEON_IPC_STS_STATUS) == AEON_IPC_STS_STATUS_ERROR)
> +		return -EINVAL;
> +
> +	/* Prevent IPC from stack smashing the kernel */
> +	size = FIELD_GET(AEON_IPC_STS_SIZE, ret_sts);
> +	if (size > AEON_IPC_DATA_MAX)
> +		return -EINVAL;
> +
> +	mutex_lock(&priv->ipc_lock);
> +
> +	for (i = 0; i < DIV_ROUND_UP(size, sizeof(u16)); i++) {
> +		ret = phy_read_mmd(phydev, MDIO_MMD_VEND1, VEND1_IPC_DATA(i));
> +		if (ret < 0) {
> +			size = ret;
> +			goto out;
> +		}
> +
> +		data[i] = ret;
> +	}
> +
> +out:
> +	mutex_unlock(&priv->ipc_lock);

I think the locking here is suspicious.

aeon_ipc_send_msg() takes the lock, writes the registers, and waits for
the success signal, returning the status, and then drops the lock.

Time passes.

aeon_ipc_rcv_msg() is then called, which extracts the number of bytes to
be read from the returned status, takes the lock, reads the registers,
and then drops the lock.

So, what can happen is:

	Thread 1			Thread 2
	aeon_ipc_send_msg()
					aeon_ipc_send_msg()
	aeon_ipc_rcv_msg()
					aeon_ipc_rcv_msg()

Which means thread 1 reads the reply from thread 2's message.

So, this lock does nothing to really protect against the IPC mechanism
against races.

I think you need to combine both into a single function that takes the
lock once and releases it once.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

