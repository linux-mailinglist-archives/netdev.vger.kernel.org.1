Return-Path: <netdev+bounces-268198-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMmkHrQouGnhZgEAu9opvQ
	(envelope-from <netdev+bounces-268198-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 16:58:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EA929CDE6
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 16:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B214230CC181
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 15:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2DF3B47ED;
	Mon, 16 Mar 2026 15:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9KP/TS+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1CB3AE70B
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 15:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773676243; cv=none; b=aSyRRHqom0zGxVZ20+CULB77zNRBN8+b3sUwcwa7pgggl8q6qqIjRZp/CU3ML4L6e0Xh3rItnZ8qtEmyJ2PTVxEFApYgaSuIFJr3yaGf20n+LHyldMohXMr/FXsp3ISxS4MacB25Za7or2hevh8DNfElYt4jd699ZPxnmhqJMi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773676243; c=relaxed/simple;
	bh=bTnwq8m4n7M6iaq0L7BMXbSoCN4UQbFTIYiV1JZMkjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P130WxwuBMtOjDFasQ6mpBAJjI3/nqdGXo5pg8iu4QXFYJohNfccj5dgUA4k2iw4cHeD7gngtFWBOW0DeRvOaK8OpE+ZF3Xn1z+DWhloK7NGIar73gpc+SBvBpahyAnVROtwQwKMQ7sNsG+OEIdIImk4iYvBgNJjOe4dMSEfxCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i9KP/TS+; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-126ea4e9694so147539c88.1
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 08:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773676237; x=1774281037; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b+F9Gr9FS46wIk1eFTmX5HV8raH1lvpgdibqFwiXKDk=;
        b=i9KP/TS+B1CFNH4mWane6GAMp9a0fn4BKynQVj29CeMczn+PNmyD+ESb7W3jlm2B/g
         Rw2pTgD+UUWky8BnDh9JVdFiFtQ/iiia0bQWeTv8iV36BZk63GfpurBthosk48UBPrTx
         /PZZlIrhIt34gEggXusEDc5AUVkWmOy53WUU//Va1ITjH/0rkvWGfXQjDmJ2uTXIf39e
         FTYcvcYL3rZKlXR3m9Di1AilA0mdCMOn5XZl8r70fJfD7aeG3E178nhDoy9JBO790nPa
         f+7LYQHz3Caidn84g0z6xwJCBPFsvSsMqySj73vpuBko5BAEiE8efKpegbSmxx+uPjJW
         tn4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773676237; x=1774281037;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b+F9Gr9FS46wIk1eFTmX5HV8raH1lvpgdibqFwiXKDk=;
        b=Wr8pdq6m0v1T3MMZuUK+r6VnajQ2tMg/8A0OstwBtRRRiq5eXbrDrVl0IJoPKQXkHL
         7Sk3bu3WTEMeE7tN2TqImGCVTBs4LcuNWJCfR5vN+2npuhTm9l70Ei+QGzL/2WqHfzHi
         Zwu/b/qvhtWLRHuRZixCruxSHoWXmr6zSRZ9NZl2pMyfTjs/UKMIlUzTLzYyyKRB+A6x
         kkdqCS8tlROM6llTtxZUDJkEPboAK77Dt4+a3ky11dtWsGBcKOCcH+R9om73lRDJUDiD
         suFfuVe6eTERXEKtMUpnH0GHOp8C5WA57lto3bEVZppAlAb5ddrThWSHXz4oUDB4uDZE
         rB+A==
X-Forwarded-Encrypted: i=1; AJvYcCWsoDzQ2EbrzO6uyA/xOBtkyvh1+CpSPcEc57Civo2qnf+ye2HJjkEBeKsj/p1Zmt1/0jucF5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUMqJjzu2DB2o9NeVK7ioecQIsH7xgNbm+cp4HxTD9NWHydMsZ
	1LakziRKp5tECHGPM1stwoaW+azlKLxcc2mubL0ykyb9JGYUgIyERUU=
X-Gm-Gg: ATEYQzyD6JGMrADfsE9+IyCHquVVJc9ZAvxL1zuOUMybf22plb1D1xW3K/7/uXW6d63
	lSCA9eQWkLfnrIBTCkhiaYdhAWOFsSkl7c1CKT+a8ojWcXvkH6rXoy6HNvXOPkFt9z/lKZNYl88
	xR9ypRO4sqM45KEFTn1XBrfOZFz6pSPXj1v8HUaSrXPBOPFuIEkNAnbvzyud1Ng9YHmY+BZo/9p
	0TGZeI/lKsQ53Cc2OPWanrMMdi/9E/EW6BfzjSXqmuVVSOIDMnzudsrwxcQPDR/F/laoj78amOw
	+xC7Ntd7a+umIuiaB9TVSwH3sS2+gD/jwBW3+dFILnV9jF5OHXNsp/aiDvJh2Cgi6XLcmp8xHLM
	ZKx0FsigEVS+9jHsn05+/b8vvtHnKcKgkhlc838CI2bTaGmussSM1l4RgInlEku5Y3Ds1zxZwVu
	pTpKMT6cfmdyjWW0vgMHKc4boXoWru0FwN9Wb0U6bjGX3Ui/I5B9N2HAbFX63swYkfh+Y9gOhZb
	+4DjWCHLEkvF+b82s5W7+l7Wxzz
X-Received: by 2002:a05:7022:618f:b0:11b:f056:a1b3 with SMTP id a92af1059eb24-128f3d3f175mr7464078c88.11.1773676237290;
        Mon, 16 Mar 2026 08:50:37 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128f63b6a34sm14699897c88.14.2026.03.16.08.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 08:50:36 -0700 (PDT)
Date: Mon, 16 Mar 2026 08:50:36 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, Pavan Chebbi <pavan.chebbi@broadcom.com>
Subject: Re: [PATCH net-next 06/11] bnxt: convert to ndo_set_rx_mode_async
Message-ID: <abgmzFReIY8m-NHy@mini-arch>
References: <20260313145113.1424442-1-sdf@fomichev.me>
 <20260313145113.1424442-7-sdf@fomichev.me>
 <CACKFLi=WRRnJqBqenwkFb+gjrpR6Y=+sz6qWbWcjAyX4tQvj3g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACKFLi=WRRnJqBqenwkFb+gjrpR6Y=+sz6qWbWcjAyX4tQvj3g@mail.gmail.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268198-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stfomichev@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fomichev.me:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D9EA929CDE6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 03/13, Michael Chan wrote:
> On Fri, Mar 13, 2026 at 7:51 AM Stanislav Fomichev <sdf@fomichev.me> wrote:
> >
> > Convert bnxt from ndo_set_rx_mode to ndo_set_rx_mode_async.
> > bnxt_set_rx_mode, bnxt_mc_list_updated and bnxt_uc_list_updated
> > now take explicit uc/mc list parameters and iterate with
> > netdev_hw_addr_list_for_each instead of netdev_for_each_{uc,mc}_addr.
> >
> > The bnxt_cfg_rx_mode internal caller passes the real lists under
> > netif_addr_lock_bh.
> 
> We should now be able to call bnxt_cfg_rx_mode() directly from
> ndo_set_rx_mode_async() without deferring it, right?

I was not sure about bnxt_timer->bnxt_queue_sp_work(BNXT_RX_MASK_SP_EVENT)
path. If we call bnxt_cfg_rx_mode here directly, it can race with
bnxt_cfg_rx_mode from bnxt_sp_task. So I did bare minimum amount
of changes to support ndo_set_rx_mode_async.

For v2, I can do the following:
1. call bnxt_cfg_rx_mode here directly
2. add netdev_lock around bnxt_cfg_rx_mode in bnxt_sp_task

Do you see any issues with that?

