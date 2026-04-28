Return-Path: <netdev+bounces-281940-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHUaBfjL8GkKYwEAu9opvQ
	(envelope-from <netdev+bounces-281940-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 17:02:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8E14877C1
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 17:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D0A0330193A0
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 15:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FF13A0E92;
	Tue, 28 Apr 2026 15:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rcxKsGoH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129593AF654
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 15:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777388509; cv=none; b=KDjIWi5XhmD2GaFP9GxPSkqbnvn9wvgnmSybYnkBHxWOEPvcopzBW3dW1LlBaoP0OgK20R724mrjcrOkFX1yHQLqJct7O5PSN1zETObZlyEKI7HGciFSFkrXF9UiVsQzOtAbuQ7iCjgG/VHs/d2O/pxrNLh6b30K4YlboCRLrVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777388509; c=relaxed/simple;
	bh=qJer4Z07xwMH+A78Ib0ymUPGWZ+mNnYVbTFhj6WGO5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DAPS6kVJu68wktCYBcEzlv0GHxAFX2s7a6uR6DgOQWEA704JEWlTJkw/pi+aYlD40P6u31zmETf4XnkhkWGIBwMEc0fvoJHkLOQOJOMH1euqGq4UvGvJQq9olAf/Uj32OHnFewPjwr8WDpwQzQZ/qsEmQkVhkRTq0dRZjF0GzxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rcxKsGoH; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ba699316b42so1456659366b.3
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 08:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777388505; x=1777993305; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TD3g81YgYyk+ev+8kkfCadZc9PhNHKB3ZIvkWb2+QeU=;
        b=rcxKsGoHWww5RWld30JP429/9DnmUPbPhP9s3JQMZUZMVmGUxjM5+KOSZe8QH5h0M4
         P40o5OfuXgNeYLZEkVFho1l9yOmpk/31nNo3IClkrFSrhUgxgQFGg+xmRat1Iuwiebsb
         VBEQ7+6vYiyimISXAd40q1kdaEebwMMLHLytbN4auGL8LvjJr/5WwROUA2n5CRzDqNHY
         LL1j1XF0aaZZRwtZ4zBw88k9YQQ/2/P4GO23nKyIkXsxDZ3AYJdEL7uuj9GbSCCyPMHp
         v91nKIaDFoe6xFXyV2khgNX9oQtsff0NGoQL3Wtg1suJS9PwP9S8ynjE/ULHdNJijLXc
         T8BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777388505; x=1777993305;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TD3g81YgYyk+ev+8kkfCadZc9PhNHKB3ZIvkWb2+QeU=;
        b=U/s2fdPGJXfO0j1pA7bwzfpG6xSsuO6aFgq5RQSlZIONcavQoQmiLfgcu9DbAonTLE
         ef6jKHdXqn4nbzxA3c6AnikVzDmOioFqZk2fcFGJzUF/EdwnuYs8yDT1eezPsqGOztTG
         c1sMrerwzzXAtXMcCHYpkriYSafa/1UnFNsa6pVuv0x45GfG8EmvF9odOMD06cfjMX6N
         XaYRM4wuyJL7PuN03Dn9f0FlwB2MI9k+s3K9xREq8DpodwgulR5Sbg9eLYukrodJYYj0
         lyxAFs0H2dLT/vTaYZKlTislrKzxEs37CCMktBBTUsgrANQNvLVj45WEMMbxSIuDGklI
         5lEw==
X-Forwarded-Encrypted: i=1; AFNElJ/2LYAEaU7KWYa89yd8zySXAmK4BjpuzQUeJ/T4sCZxIvxVgnCcwWeFeu7JQ7k+wNw/NplWn3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB1O0qPSBURcFNIp0JcWpaNVWQie16nVCNZb5mUhsfb6nhMNsJ
	GtWNle2AUhzyRF+srYqmUqBPuvYr5aoCUvGH7C1jnCmtyhEnu5TXqTooBY2AZQ==
X-Gm-Gg: AeBDievMWpu550Tdr/YO782BLIZu1/81I5oJTw8QWM1tYvDxaBl/FwPnsT/fgIX0cdg
	RgvCEucigL3tgZV3tgYWupERUCeC711UtNBDohox2c31MGt0OtLxxW4dQzRqrhW4EF+mzUAU6I+
	7/p6J/Cu5co86yIGQLxAOwN+X77hjVq2p30jR6G6rSmKaSFXHU3jFezzbqHQ+09EOWdkNPrT5F3
	RuiESUUuIDbvzxpi1/ljOqc8rFapQr77hctY3uSqAKxahRDNyhN5C9ml49d1uItWQ26hufJJpf/
	z3iW0zXa23q2Gjx1IB4Ssn7ASEwFk4GIUjwhisq3oSzhE8rm0qId2Fz9VA6S7R+4FqnYD+SPrYi
	cOQq+GVatBOy1PWFH3ZKJVqYUJ2VQFtb5CTA4KupOcDRxdbyvMrWLHuWyGa8iDP5p0p1kBCT7Lm
	IwH9OhgYGbYVP2ix4FCfNlw1D8DXwijrAthOOthifF
X-Received: by 2002:a17:907:3d45:b0:bae:70db:91f5 with SMTP id a640c23a62f3a-bb803e5c931mr212259066b.35.1777388504521;
        Tue, 28 Apr 2026 08:01:44 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb80ba9b8c8sm110829466b.48.2026.04.28.08.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 08:01:43 -0700 (PDT)
Date: Tue, 28 Apr 2026 18:01:39 +0300
From: Dan Carpenter <error27@gmail.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Jakub Raczynski <j.raczynski@samsung.com>, netdev@vger.kernel.org,
	kuba@kernel.org, intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v3 net-next] net/intel: Replace manual array size
 calculation with ARRAY_SIZE
Message-ID: <afDL02Z4QV6G0UxF@stanley.mountain>
References: <CGME20260428103757eucas1p132f3f1123fae21d596a51cbdce72c931@eucas1p1.samsung.com>
 <20260428103653.3539239-1-j.raczynski@samsung.com>
 <ef61b770-ebf4-406a-90a0-8a49aba02aee@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef61b770-ebf4-406a-90a0-8a49aba02aee@intel.com>
X-Rspamd-Queue-Id: EE8E14877C1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-281940-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[error27@gmail.com,netdev@vger.kernel.org];
	RSPAMD_EMAILBL_FAIL(0.00)[przemyslaw.kitszel.intel.com:query timed out,j.raczynski.samsung.com:query timed out];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samsung.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email]

On Tue, Apr 28, 2026 at 04:06:48PM +0200, Przemek Kitszel wrote:
> On 4/28/26 12:36, Jakub Raczynski wrote:
> > There are still places in the code where manual calculation of array size
> > exist, but it is good to enforce usage of single macro through the whole
> > code as it makes code bit more readable.
> > While at it, beautify condition surrounding it by reversing check and remove
> > unnecessary casting.
> > 
> > Signed-off-by: Jakub Raczynski <j.raczynski@samsung.com>
> > Reviewed-by: Dan Carpenter <error27@gmail.com>
> 
> thank you,
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> 
> (next time use "iwl-next" in the title, no need to repost just for that)
> 

Which sub directories go through iwl-next?  I was trying to update
my script

> > 
> >   drivers/net/ethernet/intel/i40e/i40e_adminq.h | 2 +-
> >   drivers/net/ethernet/intel/iavf/iavf_adminq.h | 2 +-
> >   2 files changed, 2 insertions(+), 2 deletions(-)

but look at these file names. There is no "iwl" anywhere in
the names!  :(

regards,
dan carpenter


