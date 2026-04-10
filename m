Return-Path: <netdev+bounces-277186-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFscNnRF2GlzawgAu9opvQ
	(envelope-from <netdev+bounces-277186-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 02:33:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3696A3D0D15
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 02:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2426D3010825
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 00:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29CB2D5C8E;
	Fri, 10 Apr 2026 00:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cd2fqneS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2F8283CAF;
	Fri, 10 Apr 2026 00:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775781231; cv=none; b=Grk1K5LIiPJq9nT/lQOpgLS+xghKyMDA2mn85BZ3fKFghEkW7qRu4YCB6dpH3tf8/fCiaqgEmGLeT7M3IjcsaMoXyU3zdqnrQHvnGrkh9uu31zY7QQ8YmdWiusnlOThpNRWWyECcszUMzRfT4PNbGF5hrBrX5QxrOK5FRftrnJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775781231; c=relaxed/simple;
	bh=sBoqYaddh3B9neU97+9gXWbck2g6i5pr5OTt9Fq9NGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YFDS3y+j8ObzabALsubg6yzuxP/CYEi8bqXGJxddzItEPgmwrIk5meFYX560MbDVT78wlMK12Coe0r7saOczLHrtj+fiCeJTeHeay5viRmUz2J/BL4LvQmObAYgfD1EnU5XTDlJmgR/ipE+zAyfeWsXv+P6SzeqVb6T5GKVlzeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cd2fqneS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E5DBC4CEF7;
	Fri, 10 Apr 2026 00:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775781231;
	bh=sBoqYaddh3B9neU97+9gXWbck2g6i5pr5OTt9Fq9NGQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Cd2fqneSkn29qcgrq9l4VD1aTCDoK9euVWf+4nzYHKUsQVTdPmaZDPqoL0fCmzw3j
	 3AjmHBAnoTIEs1zUX/wXwa3Ogih52lJMi4iil4c+W2W9zxWKU1HinXIMtnDdQwN//g
	 N7ZYXMGd++q012lUNYvol4rs0QG6jqNvUoipGWmhzXs89JpQdf/dtsJq5AvhX7Vuph
	 mAqLFIAg8jfSs+0IcB32IpUHiHmfUOdVtpfS08jDd1J40nouk/czyAMdSFbMdbvqE2
	 JVJOfjnLGwErooG4sTx/+JWuOFP5HKBX8sorGIyMGrMGtF4Mw++aLSh7tHRTnOCERi
	 EZHf+BaiC9Mtw==
Date: Thu, 9 Apr 2026 17:33:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Grzegorz Nitka <grzegorz.nitka@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, poros@redhat.com,
 richardcochran@gmail.com, andrew+netdev@lunn.ch,
 przemyslaw.kitszel@intel.com, anthony.l.nguyen@intel.com,
 Prathosh.Satish@microchip.com, ivecera@redhat.com, jiri@resnulli.us,
 arkadiusz.kubalewski@intel.com, vadim.fedorenko@linux.dev,
 donald.hunter@gmail.com, horms@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, edumazet@google.com
Subject: Re: [PATCH v6 net-next 0/8] dpll/ice: Add TXC DPLL type and full TX
 reference clock control for E825
Message-ID: <20260409173349.61d98cfd@kernel.org>
In-Reply-To: <20260409235122.436749-1-grzegorz.nitka@intel.com>
References: <20260409235122.436749-1-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277186-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.osuosl.org,redhat.com,gmail.com,lunn.ch,intel.com,microchip.com,resnulli.us,linux.dev,kernel.org,davemloft.net,google.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 3696A3D0D15
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 10 Apr 2026 01:51:14 +0200 Grzegorz Nitka wrote:
> NOTE: This series is intentionally submitted on net-next (not
> intel-wired-lan) as early feedback of DPLL subsystem changes is
> welcomed. In the past possible approaches were discussed in [1].

I LOVE when someone takes 3 days to respond but then posts the next
version the same day.

