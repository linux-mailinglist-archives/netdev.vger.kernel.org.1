Return-Path: <netdev+bounces-290270-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILH8MfbBDmrXBwYAu9opvQ
	(envelope-from <netdev+bounces-290270-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 10:27:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 54EBF5A105D
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 10:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 415833040A8D
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 08:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2F433ADB5;
	Thu, 21 May 2026 08:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xt7e4Ucz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C8031E859
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 08:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779351694; cv=none; b=t86Lc4Uu2Eum7X46siS/7jXnEZU7MTutaYLuorBf9AohraK4bCUT6JwwjWTo/vzRpz1zdkpxY1iXRxG5b1qVm1iy1kYkx9tPWK1uJWY7C7h+39ULavL1daPB2oYRdnkWkAqT/qAt820weB/t9pj++s+gbQF4HrUgmTPMU2sNRNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779351694; c=relaxed/simple;
	bh=vf9EdGOBFNbANuwgYTey8qKjUntXP7VPNSPAIl+gfHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u2gaCQSmOOosfn30IFL3FjwCCCmqDRI+xVRAytFHZ5bERTsXxSvzWMTR+vVpuDVpRz0CTg7Utw1ovFDL2foCRzbSqoN4bFpy22xCk/bCohyIUkjR6cJSxjcnJImpnzTq3IS6Jo+GROmUsc0u/iAiMlGvYGbxRhCLkuPJGEaRGq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xt7e4Ucz; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-36974221f93so3138825a91.2
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 01:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779351692; x=1779956492; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UCt+W2ieLHOKOlBw/CnoN2ocTX4F6uf8nRrco48U6qg=;
        b=Xt7e4UczfYjsyy+7xHs/Fg4STcq4KN97SmswXoFHkcS+u+/aWI0vrhIYqVR5GnXTv8
         Zu1tlP/EQxhax5gNsbMjL942TVNoR119C3bHyI5GmfKGHpX001tnwOSVGukw1nHXybbQ
         sCGco2hDqnav4UWY6hmHqqyNQiwkKfZmu/v46SbGAPqHfYN41g1KCG5NqbRDQriwpkGt
         UwexjV4fURkpu+5dz6XpAY9IdkcCsMAUDl/Rxp2E/YoODTcBPe1HwFpWKemP6LTJqib6
         NBUtiLpmewPRGt0Wb4kzPeqPd07XPq7yUF+2se+9Cxg/iDcI4MPyvZt25IR1g9lbh6NV
         uO0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779351692; x=1779956492;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UCt+W2ieLHOKOlBw/CnoN2ocTX4F6uf8nRrco48U6qg=;
        b=ovGU1qLVF5JNTUvHnl6W5i3FB4EP/+t6bdnmO5ooqGPnKLREL4NANMSVuFcp9Nq8jG
         Qb4psbyJFMBrqqseZYY5FKkZbC4KpOi0kPyHOjaIEDv0lfZYhq2aE1k/4viQFc6V5yf+
         4mj8c3m0FJmwiaGNYlLJNzjKcWHJSs5+84iCbHLtSvwVFEW4D5mCDREzCTgy5VioyGH5
         yNHYnVGQfmMHSRCb/rnC+fbTXu7voPpUAxm9LtjnKYjm1EXXs1/R7DFuvoh2p25LqI+n
         gaI0z89bN2mauQ1xt3TfQTeFKdFhs7ZNSo3shkwF5CeoJkgwWVN9VgF7a7C1vYp7eh5i
         m58Q==
X-Forwarded-Encrypted: i=1; AFNElJ/5F0or6+wPUkeucfJqvYSR80vGJlxePJDyxUBMLRn69xqpddcuhd890vii2GdWBIM1WdnCD/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhP62Pc5/jL5Rav8aCzUSmzHOctgBnOT4HNw0FxnbX6WnYMbXY
	GhFac3VTVRwL+l4RFHaG0ZZp4fNgOj4O9LvQMS/xhe9G4lxFu4JyIgkN
X-Gm-Gg: Acq92OFvvQe+RQ/Y8tf5NGM+KeWJMAbZ6Aq8QSOKQVIidijSp5PeNqJvTOD8dFj892A
	BTH03jLM4pycbemyQltjtKTDUb7jK2jsqlCvvdbg+atjZ6L2XQAJSthdcx5H6zGjLHpAm+sy1NE
	iSoy15/EDbkruqXhip/tsXMswTH+V6FTDMWrd0fUUXjSmXYxbjKgL1r30XSraPJZS5BlWaMaUNe
	qFSUyj464mLpCx0DGOwT1ybaMVMsnWKko2YfBgW7o0IDUyMrG11+qWE9E3RZyBOVtRC3wQmsisW
	71A09gB7WnLKlqClFdCK9U78WX9ssWD+JTaKaTzSFzb3q6Y0AI9h9iJnRklOD0WAEczP5sfe2xk
	eylRNFaWddJQYw0TQOlBndsHraux7x397YWSG+8HtcSuSdqnXMjRsIZ5b8f2WnfA2nLTYpCpAKW
	esHwgAohassPQ3DYcpuScSwfHTX/rlrZtjjj00VV6TfnPLFFBf9v0=
X-Received: by 2002:a17:903:2289:b0:2bd:9b0f:5f2e with SMTP id d9443c01a7336-2bea331c80emr20563425ad.22.1779351692463;
        Thu, 21 May 2026 01:21:32 -0700 (PDT)
Received: from Air.local ([198.176.50.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bea91733cdsm3043595ad.12.2026.05.21.01.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 01:21:31 -0700 (PDT)
Date: Thu, 21 May 2026 16:21:25 +0800
From: Weiming Shi <bestswngs@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH net v2] net: team: fix NULL pointer dereference in
 team_xmit during mode change
Message-ID: <ag7ANnbQ_bvzERb6@Air.local>
References: <20260509181825.1523951-2-bestswngs@gmail.com>
 <20260510082509.1530a1a3@kernel.org>
 <agCtGqWLK53TWCaS@Air.local>
 <20260510095937.598c27a6@kernel.org>
 <agrdjt6CjpJo3AYF@Air.local>
 <20260518142230.4403b3ce@kernel.org>
 <agwJNX-q0NmmrMpy@Air.local>
 <20260519162145.524da69e@kernel.org>
 <ag1PTfcsbowK68g5@Air.local>
 <20260520152018.1098f9ed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520152018.1098f9ed@kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290270-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Air.local:mid]
X-Rspamd-Queue-Id: 54EBF5A105D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 26-05-20 15:20, Jakub Kicinski wrote:
> On Wed, 20 May 2026 14:14:10 +0800 Weiming Shi wrote:
> > > From looking at the repro it seems like you never add any ports?
> > > I suspect that the author of this code assumed that if there are 
> > > no ports there must be no traffic, so it's safe to be flipping the
> > > modes. I'd rather prevent the race than make it safe. Could we defer
> > > setting the real handler until after the first port is added?  
> > 
> > The next version will drops the release/acquire and replaces memset/memcpy 
> > with per-field updates that skip transmit/receive entirely. They stay as dummies 
> > throughout mode change since team_adjust_ops() already handles them based on port count.
> > WRITE_ONCE/READ_ONCE for tearing, synchronize_net() before exit_op() to drain old readers.
> > 
> > Does that match what you had in mind, or would you prefer a different structure?
> 
> Please post it and we'll take it from there
Hi,

Okay, I have already sent the v4 version. Thank you.

Best regards,
Weiming Shi





