Return-Path: <netdev+bounces-295085-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id B5dNERk2IWqCBAEAu9opvQ
	(envelope-from <netdev+bounces-295085-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 10:23:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA68C63DF92
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 10:23:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amazon.com header.s=amazoncorp2 header.b=ET96A5Km;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295085-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295085-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amazon.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCE963024956
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 08:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D183366065;
	Thu,  4 Jun 2026 08:15:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191FC2566E9
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 08:15:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780560922; cv=none; b=mW72GwFirCBEoj/tHR3QLDlM7YUCRTO89+nv0lM74pdjFrBSiqgzqaL+mBCBoSzbAmHIOqWHq2ptnPs/1EluCA2OrhFi4KTqF82uVTt/+fD/eDto6p7F9xT/lP0hqQCxLH4v/OJPUFE9p6GYxzZRc+m4F/FuRtaheODQBRZZr4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780560922; c=relaxed/simple;
	bh=T9Dr5AfSUb7FlpAMrjrYvFnPG/WrSs5gAHmlvyEypHs=;
	h=MIME-Version:Content-Type:Subject:From:To:CC:In-Reply-To:
	 References:Date:Message-ID; b=rfUHVyXk+zJvdATGI8hdVIFejIdDt3+ub1EOw8WDKbrs4dsckuu9IZxBe+fdwEhV6DCej/Cb4qs+elFcXotPA9CsdJ3RlBDModp2E5Dqjn4AklEVPVumN7M0jhaNOSMINrGdMu1ULqgxUAs1sdSKgr4mIOgo66Gup0ZJvQj0TyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=ET96A5Km; arc=none smtp.client-ip=35.155.198.111
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1780560921; x=1812096921;
  h=mime-version:content-transfer-encoding:subject:from:to:
   cc:in-reply-to:references:date:message-id;
  bh=IRUMVylzgQSwBxG+JNA785gNPLk0r2EhqFcoeXBUNVY=;
  b=ET96A5Kmp0dFVQHp75jGu3sZrtHLA0w0jwddDrTpDJoX85pnsIF2Xu9n
   lUYhETUi9HYWW82HLlWRHSpSwZKbVHlQLoV6rw4A1kASE/tNpzP3F+UFc
   Gj4YNHW7x/KYZQsZ6ztmIFTZQ1XXkXO0RxOiQFAX4jCIcw7Ox1/Odp5rc
   dfyQwswEL6DOnS/PFP0DuM4YmEvnT5zAs7c3BDRSRY3LKH0sb+XV3R4eB
   4Pfg7WhJaL+Wy6vNopvvnKW86doW0pKufnbNbGg31Gr29UCp1j79aQBps
   c1gvJT+E0NEWUru8Sj3dQDGDq/XsNXSmBsDZhQLSUFI7YkrQKpmsgGmqE
   g==;
X-CSE-ConnectionGUID: iaB2FaZsRCW9QcEV0V7O+w==
X-CSE-MsgGUID: lNE0kdvaRtCUGoWlaC3CAQ==
X-IronPort-AV: E=Sophos;i="6.24,186,1774310400"; 
   d="scan'208";a="20958480"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 08:15:18 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.51:2021]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.10.209:2525] with esmtp (Farcaster)
 id e52586d5-31d4-45c2-8754-a47395b72a61; Thu, 4 Jun 2026 08:15:18 +0000 (UTC)
X-Farcaster-Flow-ID: e52586d5-31d4-45c2-8754-a47395b72a61
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Thu, 4 Jun 2026 08:15:18 +0000
Received: from dev-dsk-akiyano-1c-2138b29d.eu-west-1.amazon.com (172.19.83.6)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Thu, 4 Jun 2026 08:15:15 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH net] net: ena: PHC: Add missing barriers
From: Arthur Kiyanovski <akiyano@amazon.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Arthur Kiyanovski <akiyano@amazon.com>, David Miller
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, "Woodhouse, David" <dwmw@amazon.com>, "Machulsky, Zorik"
	<zorik@amazon.com>, "Matushevsky, Alexander" <matua@amazon.com>, Saeed Bshara
	<saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>, "Liguori, Anthony"
	<aliguori@amazon.com>, "Bshara, Nafea" <nafea@amazon.com>, "Schmeilin,
 Evgeny" <evgenys@amazon.com>, "Belgazal, Netanel" <netanel@amazon.com>,
	"Saidi, Ali" <alisaidi@amazon.com>, "Herrenschmidt, Benjamin"
	<benh@amazon.com>, "Dagan, Noam" <ndagan@amazon.com>, "Arinzon, David"
	<darinzon@amazon.com>, "Ostrovsky, Evgeny" <evostrov@amazon.com>, "Tabachnik,
 Ofir" <ofirt@amazon.com>
In-Reply-To: <3e241945-b0b4-4426-9863-02c25e6d6ac4@lunn.ch>
References: <20260603065532.13260-1-akiyano@amazon.com>
 <3e241945-b0b4-4426-9863-02c25e6d6ac4@lunn.ch>
Date: Thu, 4 Jun 2026 08:14:58 +0000
Message-ID: <178056089898.20259.7068674278205198994.b4-reply@b4>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: EX19D037UWB004.ant.amazon.com (10.13.138.84) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-8.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[akiyano@amazon.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:akiyano@amazon.com,m:davem@davemloft.net,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:dwmw@amazon.com,m:zorik@amazon.com,m:matua@amazon.com,m:saeedb@amazon.com,m:msw@amazon.com,m:aliguori@amazon.com,m:nafea@amazon.com,m:evgenys@amazon.com,m:netanel@amazon.com,m:alisaidi@amazon.com,m:benh@amazon.com,m:ndagan@amazon.com,m:darinzon@amazon.com,m:evostrov@amazon.com,m:ofirt@amazon.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295085-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akiyano@amazon.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AA68C63DF92

On 2026-06-03 15:02:17+02:00, Andrew Lunn wrote:
> On Wed, Jun 03, 2026 at 06:55:30AM +0000, Arthur Kiyanovski wrote:
> 
> > Add dma_rmb() barriers after both req_id completion checks in
> > ena_com_phc_get_timestamp(). On weakly-ordered architectures,
> > payload fields may be read before req_id is observed as updated.
> > 
> > Fixes: e0ea34158ee8 ("net: ena: Add PHC support in the ENA driver")
> > Closes: https://sashiko.dev/#/patchset/20260430032507.11586-1-akiyano%40amazon.com
> > Signed-off-by: Arthur Kiyanovski <akiyano@amazon.com>
> > ---
> >  drivers/net/ethernet/amazon/ena/ena_com.c | 43 +++++++++++++++--------
> >  1 file changed, 28 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/amazon/ena/ena_com.c b/drivers/net/ethernet/amazon/ena/ena_com.c
> > index 8c86789d867a..79cfcd87d4bf 100644
> > --- a/drivers/net/ethernet/amazon/ena/ena_com.c
> > +++ b/drivers/net/ethernet/amazon/ena/ena_com.c
> > @@ -1822,23 +1822,31 @@ int ena_com_phc_get_timestamp(struct ena_com_dev *ena_dev, u64 *timestamp)
> >  				   "PHC get time request 0x%x failed (device error)\n",
> >  				   phc->req_id);
> >  			phc->stats.phc_err_dv++;
> > -		} else if (resp->error_flags & ENA_PHC_ERROR_FLAGS) {
> > -			/* Device updated req_id during blocking time but got
> > -			 * a PHC error, this occurs if device:
> > -			 * - exceeded the get time request limit
> > -			 * - received an invalid timestamp
> > -			 */
> > -			netdev_err(ena_dev->net_device,
> > -				   "PHC get time request 0x%x failed (error 0x%x)\n",
> > -				   phc->req_id,
> > -				   resp->error_flags);
> > -			phc->stats.phc_err_ts += !!(resp->error_flags &
> > -				ENA_ADMIN_PHC_ERROR_FLAG_TIMESTAMP);
> >  		} else {
> > -			/* Device updated req_id during blocking time
> > -			 * with valid timestamp
> > +			/* Ensure PHC payload is read after req_id update
> > +			 * is observed
> >  			 */
> > -			phc->stats.phc_exp++;
> > +			dma_rmb();
> > +
> > +			if (resp->error_flags & ENA_PHC_ERROR_FLAGS) {
> > +				/* Device updated req_id during blocking
> > +				 * time but got a PHC error, this occurs
> > +				 * if device:
> > +				 * - exceeded the get time request limit
> > +				 * - received an invalid timestamp
> > +				 */
> > +				netdev_err(ena_dev->net_device,
> > +					   "PHC get time request 0x%x failed (error 0x%x)\n",
> > +					   phc->req_id,
> > +					   resp->error_flags);
> > +				phc->stats.phc_err_ts += !!(resp->error_flags &
> > +					ENA_ADMIN_PHC_ERROR_FLAG_TIMESTAMP);
> > +			} else {
> > +				/* Device updated req_id during blocking
> > +				 * time with valid timestamp
> > +				 */
> > +				phc->stats.phc_exp++;
> > +			}
> 
> This is a rather big hunk just to add a dma_rmb(). Please could you
> try to minimise the patch.
> 
> Andrew

Hi Andrew,

I dropped this hunk from v2 [1].
The critical barrier (which protects the actual timestamp read)
is a clean 5-line insert.

The hunk is big just because of a necessary indentation change,
the actual code change is only the added barrier. 
Since this path only updates error stats, I'll send it as a separate
follow-up.

[1]: https://patchwork.kernel.org/project/netdevbpf/patch/20260604080706.19366-1-akiyano@amazon.com/

Thanks,
Arthur



