Return-Path: <netdev+bounces-266353-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPIjLzmUsGkukgIAu9opvQ
	(envelope-from <netdev+bounces-266353-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 22:59:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C33B25891E
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 22:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 32FC83042D69
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 21:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9E83EDADF;
	Tue, 10 Mar 2026 21:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RvDF5ORZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FF43B0AE5
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 21:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773179958; cv=none; b=o1lcWRP0FFsJBBJkevKI8SY6D+KVcQPlnwsu/oFGwM+PzLzHRPkmTPgWgoUYC1puC2obEgmHbhoj/A7dx3VQI3LO2uASvJNP+0WgMtLzDRbQQbMSKOW9VlmITzXhjehbwg96507t536JSFnFwJ9BVMK377UlEAd0R1UAohwYKbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773179958; c=relaxed/simple;
	bh=hKdyWhRhCAkbG7E8ZHtWFXqtf4Qe/ei7hy67peNpqNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N2id2MU5vfTfRalimnhc8Rd1SlSvI435F143jwH/zJQ0LXdzwy1CUkZYMXh8th9h6EqG91kZss0mTC8OPWR8ueMpc+sTWonAW1a/49xgSDZVj2DMaIJwIiDRsSCGo04yID08FFuHLos9Z9MndTuI+AH+TMEVQkxe0lV3KRr16fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RvDF5ORZ; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2bdfd129c52so9580861eec.0
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 14:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773179956; x=1773784756; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NxyfcB33GE/k1PDLeg6Kuo4n34bpOdFO2uouX6LZt2I=;
        b=RvDF5ORZAKOWIxiwK6acc9j8Dh4MUwMf+1NvO0RNN9pRVlkmN3UZf9vB/eGSrIbYlK
         SruJKycc7VFyJc+oytiQdctvc9CVCzSmSay4xypOlNFJGIDZWm/1jnZluSdaFpswhe7r
         akdFAMYmC+RZ28viNco2b7Whjg/Q8u+cjpuxXZh0siVCg+MIoxxrg9nsloFY/7O7YbSu
         gstyfXH//+OPhEbh2/t2XfPSqLp76OzpsCSCLzMNCWAC7XO7iRDwPaIf7MT6iE7c+Mpq
         Mn4C/DT5RTnVKjcyo8egwa5GMg1jXcKOocs01tMnfS/neffylrbVOipKkQgc/j8wffNs
         LDUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773179956; x=1773784756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NxyfcB33GE/k1PDLeg6Kuo4n34bpOdFO2uouX6LZt2I=;
        b=j61Kw8AT5WLgOB7dXBxAblH08SxruPNNBrWhfvxSMYk/1i6cm4OKJMvrPNLJMsUQtf
         RWB7At/Kzi0fQ8R20VdJOgQI4ctFg0DQLS9DYflmZmXw2qQ//Jd4KWzciCL4DxP0hEwN
         SvJo7LfrsIBicW4zOgVE+hvFqbh3UwO9bfQJUeSlT9fKukBnepz5MMPdGnvVt+ki1/Wp
         tjNQy0U8iEy+Vq96sPjD9x8h+eIKUaDkw9BCgXSHMv+pLckSz4PCH7qdpCQFyGseWICZ
         hjUIKdkNMNQ7nrt0bz1F9UbFRQ3Da6aJM+Mt9RM8ywP9BGsc5JU3mhYBOU4Yspl68OUk
         N+IA==
X-Gm-Message-State: AOJu0YzVd1mHHpDuUajsUP+lbgZnBTI69Y6CrrAS/g/U03x9yi5JzPPB
	aFUpKaG0aL5wWZ6n9XEbg9OYrVlDc8bw1009IeexjUG4DkFjS4lcuKs=
X-Gm-Gg: ATEYQzz9dAzwc/7a/Q8KxDTBpj5w1w0QZ1YnoW+ov3LByrgBQF4fpyfY3udBm62XUsB
	dawX1klm35qyfE61ENURJbUd5qBilIVQJ4NCeM9RuhBw4ue0NHFhxVSEJ3wgsyAdz8zkCdtvZp7
	dBwa19BOHMFrHDrWJLuh5eY3LFkX+tOw47VsGnntd+jVy4D5HE9iy7kK48udsdnTV2NJ2SAB6Q1
	GYobsEYgzwpzPkGOhoPV+0SBJAKg7xEQLaWP18qwf5us5akdNmh/6OLKzQB1QlJFYge4oJhOtor
	29GfT4YNlj4eCV5zBQS7jVcOX5jJLgyrF7Bnn7hIQz7QvTZ3silo51+L1UFf2WXxNIF0TM+7Ctc
	rOFMr9OhHiMsQwqVVK68u9VX3Zj3GbWtCmBhorlKlxaLHOYThJAIrz3M0ntE2UOmmwlnbJBpSSW
	EIU4Tkjk7yENc+39lpsuSNP+7aIUzQZ4L6e59Dd86gxJ27hNGBXltEKYs9T3v2OLno0B4eXbPgT
	WpQOcOXf+lgr+2kAQZ2NONdYUAp
X-Received: by 2002:a05:7301:2f88:b0:2bd:cbc7:16e2 with SMTP id 5a478bee46e88-2be8a272742mr100548eec.13.1773179956335;
        Tue, 10 Mar 2026 14:59:16 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be8aa6a15asm127327eec.23.2026.03.10.14.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 14:59:15 -0700 (PDT)
Date: Tue, 10 Mar 2026 14:59:14 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Subject: Re: [PATCH net-next] xsk: use __xsk_rcv_zc_safe for ZC multi-buffer
 Rx processing
Message-ID: <abCUMtO8Trtzs23d@mini-arch>
References: <20260310133024.422464-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260310133024.422464-1-maciej.fijalkowski@intel.com>
X-Rspamd-Queue-Id: 3C33B25891E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266353-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stfomichev@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:email,fomichev.me:email]
X-Rspamd-Action: no action

On 03/10, Maciej Fijalkowski wrote:
> Commit f620af11c27b ("xsk: avoid double checking against rx queue being
> full") addressed a case in copy mode, when working with multi-buffer
> xdp_buff, where we were peeking onto XSK Rx queue twice, to find out if
> there is a space to produce descriptors.
> 
> Adjust ZC path to follow the same principle.
> 
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

(build bot seems to be confused because f620af11c27b went via bpf-next?)

