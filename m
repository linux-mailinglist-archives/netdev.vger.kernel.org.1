Return-Path: <netdev+bounces-269775-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UB1zKeK5vGnQ2QIAu9opvQ
	(envelope-from <netdev+bounces-269775-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 04:07:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 36ED72D5560
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 04:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2F8D93037790
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 03:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729C22DF13F;
	Fri, 20 Mar 2026 03:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P38GAKiS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638BC2DA742
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 03:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773976020; cv=pass; b=V8JhFKvCiDw8jOnCnrRPFx2jlXnphasA4O/kADIPW25wHMI5Ae9Q5Em0nnzJ64m+NJOfLQgvZkw982AzRGpYX57fWSetj01JI1CWcLiSVHFyqF/PcbutuXJx0pbBdXfp9RTCZ1w4JOPdahA7xZed0PZv9LGEp0ZGKnXFAp0OKY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773976020; c=relaxed/simple;
	bh=RM61q1uWCHCZRwTddCQGqRStiqTB47nu5R9QT11eXPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kzA8He6d9u2VfRGpao4J4P+drWAtAlrOd/0osECbhfMALa2Q/ybmu8IRfe475fLWbAe/fGLMokJrnxfr3ZzuEQM5DfTACSrA979gPqp1zBVx1BK6+X1toex+aSbc7EPazAm+JhmV0r8HaBWZ5ztnZ/BRP7nhKm+N9FGrqX3FNjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P38GAKiS; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-661cfb9f3aaso1694379a12.2
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 20:06:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773976017; cv=none;
        d=google.com; s=arc-20240605;
        b=SvTm7oEN/pbRcEWVRvfzGe3db9Vp+zeeuqUhC91x9yeqYrqejPSFn0sSqMpNcSbhbp
         ZQja1i/gEqEysJ+e5dpHjFrjkXXhfUaTqJ13AAeJVKsJSz0XaRKJzzDOlP6RY1j8LVok
         EnArOAJYPeIJ9e/lNfFG7GNvdnwUFTeWwJsbbS3lu0xoipi0tIJ0IHLdUT0CJTe9u0IY
         ZhkLrkJl3DaWxRqTQXPTkSDZ6fm/L1TmesjHyjqlKWRFKR/HCtyDrDe69/uuHa/TLICq
         +UOhnwlC31kW4kTK91hfzWiHUuYavn6+EIZeaOGWykwD560Z+O1LPe2gRQdjpe8DnHA1
         8FMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Uh2XnjWm7w7sL+W4dFrZCyFtW9ll5NN+pKsvTMlZQ8Y=;
        fh=yIBDEQs+S1VPc36Cl3E7HC+G72fwEWOKf0PwS6UlxLg=;
        b=KUBW85YBhQY0rlduAS9vDeRlHDWd+BMwmk/WbNJYWUeyEcXYx3TMSlDaG2tYkWDOti
         lCVo6+T9cQzOo6+TMGsNGzjiJ9pufWuCSpibwtc64kZxvxyytAq+zrFIlXvm3H4fwDGu
         IcV7UJHJG9uP9u7qPPfyP8fz4dCqYU8HOnw1ZcHu23GKRSjl3YGw6SHI0oDXZO7Zh0AJ
         M8VcMAVIWWDOD43KcmtVAv1MIzD3ehj5cSMHjmMZiqoco+gM0L6HBtSY04CnNu3uIriK
         qrLtEFN8Wvef4MTUq89pfl5xSfAOMVDof9a8zPrzJqN4eLPiNlN7qunN8EC2OgzexK5H
         GKCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773976017; x=1774580817; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Uh2XnjWm7w7sL+W4dFrZCyFtW9ll5NN+pKsvTMlZQ8Y=;
        b=P38GAKiSckd6RQ8mw1MTp1jSkRxdKQDOrw30O2mz70ISZusHIgL3fz54rem2bxe/so
         1fRwPur6hGB6B9gWAWxuU/ajnBQsFO9kdqJ4cK2k+ue5aZd6okSeM7OhMZiVicBdoYTp
         AgIJoaX1oEaUKiQx8GLQdeuC2YeAJPDn2zOUe4VouDr7GJ9mdu4S5rCMIkewvb3vLAPb
         rvJvoEjNvWjLBAc8qpYygJGjCjMtgV5Hv2qalsImM18k7cB6jNVfzy2C8P3nNygxsCY2
         3Wi1o1TlJxEaE/9lAoRcwrox6ZyYb+tfh0P+azOSYjFMwZMK21c7UjJeMOfHM6WPs1DK
         WZlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773976017; x=1774580817;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uh2XnjWm7w7sL+W4dFrZCyFtW9ll5NN+pKsvTMlZQ8Y=;
        b=nttNCxM4+FUJYeGKkBhQkNzDYHZtpVOFYO8kl/MLf2k3uCDqrgw56D/yzI0lHrB7rE
         N5leTrqSfDC0l4iBcrXx/97qLhicPNldW/pzkT0b3eLe8d84ApnYryKwvJtnpuBm3WQw
         EhS8/u4cNcrSF/5aND6WfP/kmygs1xj3olFK4lnD0OI+iBLbYHXDrrw8HUMS4SpZhO9k
         Z5iEanbUdkMRT6gtRm4/2TXKx25PRchvzsSm53aQpjnh+uO93DlHrtbI17n8h5ehQ+hm
         gZz3zjY6M2cNyo+JZEOXFfIXCNn48MQwK6sSlXC1W8Lqawe/42KNIhHdrA9B1MDr11Jg
         C6Dw==
X-Forwarded-Encrypted: i=1; AJvYcCWxPGpCIItHwpw7KV+muRC/Qka1hLbd1Thp+mKqd0EH/6s5p8TWnwKfM2B2XKAHagFuRseHl4w=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg3RlZzi+MGxn2D5bdFh5RcIQdPDaiqQlYIe5TSmft8lB8d2hy
	l5qxJC8bipgn5CKBRPm3kWihnXaLV0KWf96jkQsQasMdzQYsUpzHADpu4lkNxoxv9i3aAD1B6mi
	atBDDVWn0vcl428irjf9JW/dCbs4VY9g=
X-Gm-Gg: ATEYQzyupSo5O1GK3gJBSDYcANcaaIWN2sXu4uIdqQ/Hy51l5AVd6cZX2hZqAQL7YDF
	h0ri5lZYA/RVuZemxGzGIkkbl1LbRegofmdMNvSHbS8luyCGqmEdzG9KtwcrYy1y7ynyyfZY6XF
	eQ82s/8ENM3t54eg4GI5XF2Pb/rNuELU3yF+MrJkRgz66CNJ/WdWuxWUFxO6TbnTQX2wHAVEps+
	WkwzCWhqTTZQC87ZT28vufBEsBu7NA3hG3BCHEZRcqEdeyws5eCYA1kiq6CmSkbiKfB/+QczJ1g
	hcM+eA==
X-Received: by 2002:a17:906:240e:b0:b97:f12a:3f8c with SMTP id
 a640c23a62f3a-b982f1ffa96mr69781266b.20.1773976016363; Thu, 19 Mar 2026
 20:06:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317061700.7734-1-linux.amoon@gmail.com> <202603200758.vueafhDW-lkp@intel.com>
In-Reply-To: <202603200758.vueafhDW-lkp@intel.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Fri, 20 Mar 2026 08:36:40 +0530
X-Gm-Features: AaiRm5341vISAh2YMw8-vBK1a-KteoqiImPAmam6qIBBOzrX-3-bGM_THq4e-Z8
Message-ID: <CANAwSgS=TzC=QVs2Mw1qJxDffj5H6gU7Ak=Kdd_pCf_1sgY74Q@mail.gmail.com>
Subject: Re: [PATCH next v1] r8169: Fix PHY lookup for mdiobus_get_phy() and
 improve error reporting during probe
To: kernel test robot <lkp@intel.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>, 
	Hans Zhang <18255117159@163.com>, Niklas Cassel <cassel@kernel.org>, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org, 
	Robin Murphy <robin.murphy@arm.com>, Danilo Krummrich <dakr@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269775-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,rock-chips.com,163.com,vger.kernel.org,lists.linux.dev,arm.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.522];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linuxamoon@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,01.org:url,intel.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 36ED72D5560
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Kernel test robot,

On Fri, 20 Mar 2026 at 05:25, kernel test robot <lkp@intel.com> wrote:
>
> Hi Anand,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on 95c541ddfb0815a0ea8477af778bb13bb075079a]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Anand-Moon/r8169-Fix-PHY-lookup-for-mdiobus_get_phy-and-improve-error-reporting-during-probe/20260317-183327
> base:   95c541ddfb0815a0ea8477af778bb13bb075079a
> patch link:    https://lore.kernel.org/r/20260317061700.7734-1-linux.amoon%40gmail.com
> patch subject: [PATCH next v1] r8169: Fix PHY lookup for mdiobus_get_phy() and improve error reporting during probe
> config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20260320/202603200758.vueafhDW-lkp@intel.com/config)
> compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260320/202603200758.vueafhDW-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202603200758.vueafhDW-lkp@intel.com/
>
> All warnings (new ones prefixed by >>):

Please discard this patch.

Thanks
-Anand

