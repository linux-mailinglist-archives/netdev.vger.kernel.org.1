Return-Path: <netdev+bounces-270174-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 7ZQQOBNFvmmNLQMAu9opvQ
	(envelope-from <netdev+bounces-270174-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 08:13:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1702E3EDC
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 08:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6F7903015163
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 07:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67BB314A90;
	Sat, 21 Mar 2026 07:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="JtUb3ghT"
X-Original-To: netdev@vger.kernel.org
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A7428D8DA
	for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 07:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774077196; cv=none; b=IQvpsEEEYJuR701i4edd/Qhy4RjG8hmCJoxLNS2q0OiWxmfj9EVlLdFS3yv8jTubrOwChLcRf9IbiamJuTkGTThElyIQl20olCPGgJt53t4uQLL2BjmiPckbSqBL9Z2SV8miEZV93G9F8bNpGLKcfYmPUEFwobAuAiZXCLVsycM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774077196; c=relaxed/simple;
	bh=Jqzt1wohnmdJUD9hk9iya6d2TGTyD7GF60/4d6X/4zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aCvHFljfpOGlZufCNEQmCtJ7gCa9QXkhL/HlImq2FGL4Z0fTSUfNLz3sUNV0o67HwXlLG5Xd750/HbVLTXcVpZoCylzYUkkHqgBi7eKRwKlOrh4w68Gvybm0c/Ku+djby5cCDfMwxQxUg4IzdWQ72MpiEyYsuPAJ1WHs1jG7wQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=JtUb3ghT; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Received: from x1 (122.24.31.150.dy.iij4u.or.jp [150.31.24.122])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 62L7D5sQ089997
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 21 Mar 2026 16:13:06 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=uLHqQj34n75qO7wvSMbuHtDwvogwxolNUwo4NK7ta/8=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20251215; t=1774077187; v=1;
        b=JtUb3ghTj8Ha7O9mQq0ln+SFa8s+LDZ6sqhDGYPYRCThvtIHq1s7BPV4oGxLVCSu
         9ZhdJVH6Z8g0romwv0kGHa3Yn4tOComdMh3+tppz5xwxLKzJuDfeyrplmIWaQJMe
         NMcnnkgLnJHQMmG0PQehgDgpsiy9jznFTfRjkkGtt17sLx/2uWJtFD6Sl0Zt2zV8
         xAp2fBRtGxIYzeBgUoNDOWYYtac187lGT683XJC0edMnEZwkcNhauiVhATFyigVB
         rhECiTCaonWgNuRol7JZWILWGki+7G2HrMF3OwbCwqxOdtjOldBUmDDPkVcnrJvT
         6y5k+tk26L8Vqyn/x319ew==
Date: Sat, 21 Mar 2026 16:13:05 +0900
From: Kohei Enju <kohei@enjuk.jp>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        Simon Horman <horms@kernel.org>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, dima.ruinskiy@intel.com,
        kohei.enju@gmail.com
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2 0/2] igc: enable build_skb
 path
Message-ID: <ab5EzGyepRd8paKm@x1>
References: <20260317062205.39406-1-kohei@enjuk.jp>
 <20260319161140.GI1753385@horms.kernel.org>
 <abzhZsk5FdB2eWeN@x1>
 <02552c4b-e4ba-4750-afc9-aaa2a671f964@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <02552c4b-e4ba-4750-afc9-aaa2a671f964@intel.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[enjuk.jp,none];
	R_DKIM_ALLOW(-0.20)[enjuk.jp:s=rs20251215];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270174-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.osuosl.org,vger.kernel.org,kernel.org,intel.com,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kohei@enjuk.jp,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[enjuk.jp:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BF1702E3EDC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 03/20 13:30, Tony Nguyen wrote:
> 
> 
> On 3/19/2026 11:05 PM, Kohei Enju wrote:
> > On 03/19 16:11, Simon Horman wrote:
> > > On Tue, Mar 17, 2026 at 06:21:44AM +0000, Kohei Enju wrote:
> > > > This series enables the build_skb RX path in igc, which is currently not
> > > > enabled in any configuration.
> > > > 
> > > > Patch 1/2 adds missing RX hardware timestamp handling in the build_skb
> > > > path.
> > > > Patch 2/2 enables the build_skb path when XDP is inactive and other
> > > > conditions are met.
> > > > 
> > > > Tested on Intel Corporation Ethernet Controller I226-V (rev 04).
> > > > 
> > > > Changes:
> > > >    v2:
> > > >      - don't insist on reverse christmas tree, reducing net diff in the
> > > >        patch 1/2 (Dima)
> > > >    v1: https://lore.kernel.org/intel-wired-lan/20260307182808.155027-1-kohei@enjuk.jp/
> > > > 
> > > > Kohei Enju (2):
> > > >    igc: set RX hardware timestamps in igc_build_skb()
> > > >    igc: enable build_skb on the non-XDP small-frame RX path
> > > 
> > > For the series:
> > > 
> > > Reviewed-by: Simon Horman <horms@kernel.org>
> > 
> > Hi Tony, thanks for applying this series to next-queue.
> > I have a question about the process of patch submission.
> > 
> > Sometimes reviewers give RB tags for a whole series like this, but I
> > think that those tags on the cover letter are not collected
> > automatically, right?
> > 
> > In this case, should I add RB tags to each patch if I respin for other
> > reasons, or what is the recommended way to handle this?
> 
> Hi Kohei,
> 
> If you need to respin, feel free to carry the tags over. If you don't, I'll
> bring them over.
> 
> Thanks,
> Tony
> 

I understand. Thanks for explanation!

Regards,
Kohei

