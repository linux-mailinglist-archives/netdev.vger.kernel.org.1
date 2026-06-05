Return-Path: <netdev+bounces-295995-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id F4QYLR9bI2o0qwEAu9opvQ
	(envelope-from <netdev+bounces-295995-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 01:26:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4E864BCD1
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 01:26:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=E7403+Oo;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295995-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295995-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AC8793016693
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 23:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356433B71BF;
	Fri,  5 Jun 2026 23:26:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1FB30D401;
	Fri,  5 Jun 2026 23:26:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780701978; cv=none; b=sIa9UXDVC9/QR2Wsg7FUmIGUKcISTXG1HfqwaIYgGtd3CnFrAVkJg8cSBw5GMs+QMx2DGpSMeNjpeYguh506ipB3V/8k36w4XAlEKH/83Glzfn+7llNR1nGnvDjhrPNvBJbS+SOXBFPoMFFKmqJ5SbT7lPNDj5ToWHFwhs0z964=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780701978; c=relaxed/simple;
	bh=KnZFrCUbyhR+riefVqmFHD4g1Bj567ZClbQUDv/JWMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jVy+gsvurY6mmgSZrwbcCOFV2Htrnkfq3tChlVRIj5veTVjJAN8dkz7ww8y01ALIFHg1T+xFV0eUypedLU0xjHOSqZ0Mzqu28ZMJFEq97UhzhakwVeb9N7t95gji1MGH0a5FhEIDzT4xTLWkni0urr8bShlkZ9yQSdabpTFVPAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7403+Oo; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29FBD1F00893;
	Fri,  5 Jun 2026 23:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780701976;
	bh=IG96N48IaU0YB7Fwkuesk+PO+SJtj7KaqjiAzFCI5Ao=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=E7403+OodPvRrNF8Mu0tD+WtYtsyw6n74A4QVl6z/iRe4WKlz9LJkPJfmpHf8WcEk
	 1RoDOPsMm31w8ml9+DhR3SJuo4i5omE65p5UL1zp/fKi3IRzx7dAgtqZ5rB2T8JHCX
	 Dz9pAASe2FCFJq9BUaXNeKC2l5HTg31yR9IBmDe20nYxJ4F0p0oVMy8Xo4U2YnDTVd
	 aPuAr9BrPNqhLX/3NoBy45reAkNQtPNpTS8l5iFhQ1GBAUwCeD17ddf7dnSCNsbjhD
	 d1AN7RDTojfSWFZDgAjDYl2DNqgpHj0oojBw5JQooiRDROVnTS9avrCEA2JPartTrY
	 rZpFXnToUrJMg==
Date: Fri, 5 Jun 2026 16:26:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Nitka, Grzegorz" <grzegorz.nitka@intel.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "Oros, Petr" <poros@redhat.com>, "richardcochran@gmail.com"
 <richardcochran@gmail.com>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Prathosh.Satish@microchip.com"
 <Prathosh.Satish@microchip.com>, "Vecera, Ivan" <ivecera@redhat.com>,
 "jiri@resnulli.us" <jiri@resnulli.us>, "Kubalewski, Arkadiusz"
 <arkadiusz.kubalewski@intel.com>, "vadim.fedorenko@linux.dev"
 <vadim.fedorenko@linux.dev>, "donald.hunter@gmail.com"
 <donald.hunter@gmail.com>, "horms@kernel.org" <horms@kernel.org>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>
Subject: Re: [PATCH v12 net-next 0/8] dpll/ice: Add generic DPLL type and
 full TX reference clock control for E825
Message-ID: <20260605162615.0987ff2a@kernel.org>
In-Reply-To: <IA1PR11MB6219C1EF3BF8160226E5826992112@IA1PR11MB6219.namprd11.prod.outlook.com>
References: <20260529142628.1678955-1-grzegorz.nitka@intel.com>
	<20260603183036.7c4762d2@kernel.org>
	<IA1PR11MB62197FC8E64BE92FBC108E6992102@IA1PR11MB6219.namprd11.prod.outlook.com>
	<20260604155422.167314ff@kernel.org>
	<IA1PR11MB6219C1EF3BF8160226E5826992112@IA1PR11MB6219.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295995-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:grzegorz.nitka@intel.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:intel-wired-lan@lists.osuosl.org,m:poros@redhat.com,m:richardcochran@gmail.com,m:andrew+netdev@lunn.ch,m:przemyslaw.kitszel@intel.com,m:anthony.l.nguyen@intel.com,m:Prathosh.Satish@microchip.com,m:ivecera@redhat.com,m:jiri@resnulli.us,m:arkadiusz.kubalewski@intel.com,m:vadim.fedorenko@linux.dev,m:donald.hunter@gmail.com,m:horms@kernel.org,m:pabeni@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.osuosl.org,redhat.com,gmail.com,lunn.ch,intel.com,microchip.com,resnulli.us,linux.dev,kernel.org,davemloft.net,google.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AE4E864BCD1

On Fri, 5 Jun 2026 16:10:19 +0000 Nitka, Grzegorz wrote:
> Hi Kuba. Just submitted v13.
> 
> It includes the following fixes for pre-existing issues:
>   - dpll core fixes. Each AI review concern (3) is addressed in separate
>     commit. If you think it's better to squash them, let me know (however
>     it addresses issues from two different 'old' commits).
>     Also, the hint form AI  to use different dpll xa_array (parent not pin) to
>     address one of the issues, it simply does not work (WARNING flood observed,
>     more details in patch 3/11)
>   - ice driver fix for potential hung on flush_workqueue in error path for FW node pins
> 
> As you noted, two other pre-existing issues are covered by ICE_FLAG_DPLL.
> I left the code as it is for those concerns.
> There is one more pre-existing one, related to ice_ptp_link_change. As the fix seems to be
> rather simple one, I believe I need more time for more comprehensive testing.
> So my preference is to go with standard fix-path on 'net'.

SG, thanks!

BTW either you or Arkadiusz should chime in on the NCO thread, please:
https://lore.kernel.org/all/20260531194423.383366-2-ivecera@redhat.com/
Shouldn't take much time to express an opinion, I hope.

