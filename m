Return-Path: <netdev+bounces-288361-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEMfKiZYB2pmzgIAu9opvQ
	(envelope-from <netdev+bounces-288361-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 19:30:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA7A555208
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 19:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 857083364F33
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 16:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0953F6C56;
	Fri, 15 May 2026 16:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZsQkFL2X"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1AB3E00A3
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 16:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778862095; cv=none; b=rjQxdOs/EGJAYPsCwk10nxehX3IcOxqUL9USRTT/N5yjgvoAsjEVMrUHMaZb3M6A3dRSGd14FJi2qdZg0uacxqO7kZGGCsQkF2u2ZN4JdTCGAc4UHaHMO0AMAG++fa+WijtbhJHH9Qj5xH9Y24VSRFxunMrbJDASwc1lOdeAh90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778862095; c=relaxed/simple;
	bh=VaLnYsZ5jUTj/7eXesrqYg9o6HiF7DOwNnzsogKf/3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q3mZbomunCu0zdYJvXAskC7ZGkGWKda/0Ptip3ot1aKPmyjHra/yy+Afva35IQXXTPPEWZt7WOtvemSzAdaUPA2S2h1Od209CuwOP5bIMYoBhozz/LSTY0nguZzrZIkS2WaEnqfwWVqZa9veOSzLbaHqd2Di7tZZST/7bSimORI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZsQkFL2X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78525C2BCB0;
	Fri, 15 May 2026 16:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778862094;
	bh=VaLnYsZ5jUTj/7eXesrqYg9o6HiF7DOwNnzsogKf/3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZsQkFL2XrcdsPySWMm/2bZcc8c+jL+wlftQ4S+isnHHkNcTMgJqXUB0+undHXT111
	 YwYkrxWp9OiUQHoMU0/QnqBAv2coM++RSk1/CB8zo4f89nhyQZc6kycKVtc2bXeh9I
	 VdsDXWNSjvIdxlvMaVrRja5h82fjxyXLiBjp1h/q7emyQ0oG2wyDPcxLI8m2sOI2P0
	 jwGjQT5bIkk8W4BBiRE6oXHPXo0brHu0al3R7mwshOTWVlEqsMFdNG7J5fcVj8gYcq
	 wlsDG8/Nb4NYJ18YBPVY/3mx4TUWXVsV/IYxRo96yCdV8I7J5B7UFkk2HF0L6JTWAr
	 KMCXQS3tuaYcA==
Date: Fri, 15 May 2026 17:21:30 +0100
From: Simon Horman <horms@kernel.org>
To: "Korba, Przemyslaw" <przemyslaw.korba@intel.com>
Cc: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
	"Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
Subject: Re: [PATCH iwl-net v2] ice: support SBQ posted writes with
 non-posted support for CGU
Message-ID: <20260515162130.GA227382@horms.kernel.org>
References: <20260508102247.826375-1-przemyslaw.korba@intel.com>
 <20260512092740.290008-2-horms@kernel.org>
 <PH0PR11MB4904E65A7FAA26DD5B6EFBE994072@PH0PR11MB4904.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH0PR11MB4904E65A7FAA26DD5B6EFBE994072@PH0PR11MB4904.namprd11.prod.outlook.com>
X-Rspamd-Queue-Id: 1DA7A555208
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-288361-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,horms.kernel.org:mid,osuosl.org:email]
X-Rspamd-Action: no action

On Thu, May 14, 2026 at 11:58:20AM +0000, Korba, Przemyslaw wrote:
> 
> 
> 
> > -----Original Message-----
> > From: Simon Horman <horms@kernel.org>
> > Sent: Tuesday, May 12, 2026 11:28 AM
> > To: Korba, Przemyslaw <przemyslaw.korba@intel.com>
> > Cc: 'Simon Horman' <horms@kernel.org>; intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; Nguyen, Anthony L
> > <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Loktionov, Aleksandr <aleksandr.loktionov@intel.com>;
> > Kubalewski, Arkadiusz <arkadiusz.kubalewski@intel.com>
> > Subject: Re: [PATCH iwl-net v2] ice: support SBQ posted writes with non-posted support for CGU
> > 
> > From: 'Simon Horman' <horms@kernel.org>
> > 
> > This is an AI-generated review of your patch. The human sending this
> > email has considered the AI review valid, or at least plausible.
> > Full review at: https://sashiko.dev
> > ---
> > ice: support SBQ posted writes with non-posted support for CGU
> > 
> > This commit introduces non-posted SBQ writes while allowing posted writes
> > to skip completion waits. It also adds an SBQ flush by reading address 0
> > from PHY 0 before issuing a SYNC command to ensure writes are completed.
> > 
> > > diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> > > index 24fb7a3e14d63..ec4c85ad12e4d 100644
> > > --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> > > +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> > > @@ -352,6 +352,17 @@ void ice_ptp_src_cmd(struct ice_hw *hw, enum ice_ptp_tmr_cmd cmd)
> > >  static void ice_ptp_exec_tmr_cmd(struct ice_hw *hw)
> > >  {
> > >  	struct ice_pf *pf = container_of(hw, struct ice_pf, hw);
> > > +	struct ice_sbq_msg_input msg = {
> > > +		.dest_dev = ice_sbq_dev_phy_0,
> > > +		.opcode = ice_sbq_msg_rd,
> > > +	};
> > > +	int err;
> > > +
> > > +	if (hw->mac_type != ICE_MAC_E810) {
> > > +		err = ice_sbq_rw_reg(hw, &msg, LIBIE_AQ_FLAG_RD);
> > > +		if (err)
> > > +			dev_warn(ice_hw_to_dev(hw), "Failed to flush SBQ: %d\n", err);
> > > +	}
> > 
> > [ ... ]
> > 
> > > @@ -4469,15 +4482,15 @@ static int ice_read_phy_reg_e810(struct ice_hw *hw, u32 addr, u32 *val)
> > >   */
> > >  static int ice_write_phy_reg_e810(struct ice_hw *hw, u32 addr, u32 val)
> > >  {
> > > -	struct ice_sbq_msg_input msg = {0};
> > > +	struct ice_sbq_msg_input msg = {
> > > +		.dest_dev = ice_sbq_dev_phy_0,
> > > +		.opcode = ice_sbq_msg_wr_p,
> > > +		.msg_addr_low = lower_16_bits(addr),
> > > +		.msg_addr_high = upper_16_bits(addr),
> > > +		.data = val
> > > +	};
> > 
> > Since ice_write_phy_reg_e810() is updated to use the posted write opcode
> > (ice_sbq_msg_wr_p), it will skip the completion wait and return immediately.
> > 
> > If the SBQ flush in ice_ptp_exec_tmr_cmd() explicitly skips E810 devices
> > via the check for hw->mac_type != ICE_MAC_E810, does this leave E810 PHY
> > writes entirely asynchronous and unguarded?
> > 
> > Could this lead to a race condition where the writes have not actually
> > completed before the SYNC_EXEC_CMD is executed?
> 
> Hi, thanks for review! 
> With E810 only opcode 0x01 for writing is supported.
> On E810, the FW always sends completion responses for opcode 0x01, so the driver waits for each write to complete.
> On newer E8XX devices, opcode 0x01 is truly posted (no completion response), which is why the SBQ flush is needed before SYNC_EXEC_CMD.
> Since E810 writes are synchronous (driver waits for completion), flushing SBQ is unnecessary - all writes are already complete when the function returns.
> I can add comments explaining that, or make it a bit clearer in the code if you'd like 😊

Sorry, there was supposed to be some extra text along the lines of seeking
clarification.

Yes, I think it would be good to add a comment or something to
the commit message about this.

