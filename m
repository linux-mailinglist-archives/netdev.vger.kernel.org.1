Return-Path: <netdev+bounces-289605-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qL/jHdvFDGp2lwUAu9opvQ
	(envelope-from <netdev+bounces-289605-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 22:19:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D98C658495A
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 22:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FAD7300A611
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 20:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CFA33B38BD;
	Tue, 19 May 2026 20:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKu+MBJf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5331F936
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 20:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779221976; cv=pass; b=Z5V2oXlJK1kZOnqnjvAuZwTX/ENMt7hQYelKr33N0UQ0Zxoi0F522gi3qkVDKDXy14EB3mheqd/1mpQnzN8Mws+EsxC4IlZnOw/9enTwSWioCi9MJJN2XMtJWuMt49BvULohAAhk0uuDLE1K5WxAEZQB3vev/EE/rddavfbQ5fU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779221976; c=relaxed/simple;
	bh=uVwZDmA/DiiIDGng7o/FHq145x3NdX3CHZlkoNsYa/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X87tD7Ddyc3cYbZMPW9e1WlDQ4er04kXWKwrNgYy6Q4d0JJCwS6hc1kQqUVQIqGG3x3M/tr0//dRT/XHIY3lRvxo6D14BlpMRo8QIjnk4bXtbcqhNZ5IMB90jpInPOXPSgtGDbact7XbJ7RZlNN7F161dBt7MGRZDls0pA7du1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kKu+MBJf; arc=pass smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-68470763896so2106388eaf.1
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 13:19:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779221974; cv=none;
        d=google.com; s=arc-20240605;
        b=BTKPo/oJiuZRt5bGu55XNwF4DCcskkvDRqOzMkPpqfpvhsPkQDGjkLbj0WfiR7B//F
         BP1WgYUszwhrI04d+P+EzKTRTvDfzCcoB2APK2SteujiQV3GcsNWc0HCjWD/IR+v8C/J
         WX13FmhgJiJW/E5VhrB0vxj5M9LWHtb082C/XLdErG9QB5NbxcM2j1tk9umKgg3tuBSS
         YQ24BAv0GsX8of1SPi7AozNAhlAn3ocQaPKMk6IBlA8jpE+RHCZYN8RZkHeO75vfHrGc
         dk8xZSqLkRtjqxy07PE9CuWKgzGUQ9YOkN9C6kKaUiyXw/PGt7OYM5aFPWD4yTpNKVLE
         SZew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=EDC3bKh8/p4QwHADrhgrb3dyAQ2dl37DGNBILQ8Vl0Y=;
        fh=ZV6+SpiRek32LwsRjAGD6Ior+A/eOEXIeZgREsU6/7Q=;
        b=YpNVwkbMesFVq5sY7iEHVv736i0Qfe7mV2w5OgvQECK0xiwItbc6SMidmopocZ+f1C
         yVOIfTEh+nQ8yO3zUbo3a/Fq/59PFScBk+UfDbkV/aZW8VPa2F323t13u4oZRzw2zbMJ
         Lc9IuqlRq2YNNI6IrECx9nArTF3Ere1+eedLVQqHYxzNRQ5kfixR/Z2T9DJ6ZzJcHIxP
         6Y/neYehoRpNGtPofAH9eiX4L6McBWjne38sBT41aJ7Ui4Kl8+B3aPty8fJfpUU1i656
         l2/pC4beM9QJDF61XAtFDIvu1RKRdaWpnhX+XZBGJWt/gV4cFsp8C0GvWVKkiLPnfksz
         U9pA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779221974; x=1779826774; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EDC3bKh8/p4QwHADrhgrb3dyAQ2dl37DGNBILQ8Vl0Y=;
        b=kKu+MBJfcOLpMf6mpsu6AD8GrFTa00enG3tFLECBLBXiIMV52HQA9EECnf2gRV2YbY
         dX81E0k64omJlWOwRAbtkR6sKkaP7+dDtRkS99v1IWRcyMn6CjT1RWGb/QZe8FgKVxx0
         tH1SriXOjdyOMtZVKc/AvQaUVYO5J7I5R5kmpdRNBMZBelzQXh9g6i/F/1BnxViEKI6k
         5U+JcMCdV+Z8OTc2D8JpHfQ4g/VrXPSh31xQeD6pZGUH2PLOITPxDgMMpWMFSMyXMAD9
         A4ltVJDRNfTK9k/siexqbKgtifVDKZ2G9BWbJJVEmVe0hJdDuKkzGPCAT/ua75ej1Vwn
         on5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779221974; x=1779826774;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EDC3bKh8/p4QwHADrhgrb3dyAQ2dl37DGNBILQ8Vl0Y=;
        b=FSDOuCUKbuDi8uAbRPmzNQIdq2YceCuWWlFlc9rwaPHcW6qqPsN9HQpZFsCej57uQ/
         zBTpyIwLEIdmqpKBTOryUZyjp+Qe0TQl26gdXA+kpZdkqPnjkmYAhfBxjnxoNaySNJ/h
         ZAXflazO0RW8VyPlGodDasQSGTgRIzNdNhC3QRcNZQ3l7UTtbj19RqJwpaUBayDZ0fH5
         uyMWsTZ5YwwfiCx3RAu7e6d51zefJkKur8ercMRXoKBt0N5dhAAyGoe8xPU/Vsol/FBC
         fG+uNUNHzSZKsoN87Tj1buLiAOozI1gFx5NCNJGu/UWGpiTW+I21IoTu4enL1orW42ml
         JDAw==
X-Forwarded-Encrypted: i=1; AFNElJ8NCDH0kBArDaLb9bjy4qO89IhNxxYkfYhKkkkjY8SWp5CGLeW1Lkj+lwx5ETmx5NCZYOdSRlM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzWi2YxHTvzNImQQzEHh2FMo0wK3cpiDujtvViU2s7aXLknmBZ
	h4dDgiGaKiXbHD5QkSdwHXwh8gZCxWoA8geKPthxhFDX7X4KFHk5gf0N7sQZsdfesEJafBHbIw/
	FyEl24woqb9S/+znZ5bVsmTHo9+z9OLI=
X-Gm-Gg: Acq92OF50DJYg8ml+u/WQxCfuPx9UIv22vmRA/RgEgxa9DOWJgvfElF9Ou9+eZqCM4/
	uR+bzs1mfZrL4ZONGg+w5zf2MaGgkQeh28WjDxGMg5IYaivnKCdjmMDJmniVHOlUibDjfAH70WX
	+PqI6wiNPmkfqhK1mSdoos8QkCSlUZJWmwRi9utJwRsQzql7C3qJs+E/0F7CQrM9KDsJBp6EtDv
	4jykplaNhV8DRCs2VrpzKz+ZUnmhjYvR7QU2CWH3GL5qN7qDCvM7S/hdF761+Km6o5AafqpVHCO
	CuLq43xBzzGFjPm7kcTjfMlV5HOoFCqrKBJ0fQ==
X-Received: by 2002:a05:6820:8184:b0:696:15ed:69fa with SMTP id
 006d021491bc7-69c94588db6mr13429873eaf.48.1779221974374; Tue, 19 May 2026
 13:19:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514183019.49527-1-devnexen@gmail.com> <20260519195734.982404-1-horms@kernel.org>
In-Reply-To: <20260519195734.982404-1-horms@kernel.org>
From: David CARLIER <devnexen@gmail.com>
Date: Tue, 19 May 2026 21:19:23 +0100
X-Gm-Features: AVHnY4JJ0Sk-6eRtWSkgzWM6vbD_3Px-KdWLRziSGPAucGEK3w1KDvkaEUsVkxI
Message-ID: <CA+XhMqxFmJm_fQ9aqRmwbG10+Bs8RgJ5kAff9-qtcrvgmfFMug@mail.gmail.com>
Subject: Re: [PATCH net v2] idpf: handle NULL adev in idpf_idc_vdev_mtu_event
To: Simon Horman <horms@kernel.org>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289605-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D98C658495A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> This is an AI-generated review of your patch. The human sending this
  > email has considered the AI review valid, or at least plausible.

  Thanks for relaying this, Simon.

  The scenario this patch fixes is sequential, not concurrent:
  idpf_idc_vport_dev_ctrl(adapter, false) has already returned and
  vdev_info->adev is NULL by the time ndo_change_mtu reaches
  idpf_idc_vdev_mtu_event(). The original code dereferenced
  vdev_info->adev in device_lock() before the NULL check and oopses
  deterministically; READ_ONCE() + early-return resolves that.

  A truly concurrent idpf_idc_vport_dev_ctrl(_, false) racing an
  in-flight MTU event is a separate, pre-existing window: the original
  code took no reference between reading vdev_info->adev and
  dereferencing it either, so this patch neither introduces nor widens
  it. I haven't constructed a concrete interleaving against auxiliary-bus
  teardown and have no report of it triggering.

  Happy to post a follow-up bracketing the handler with
  get_device()/put_device() if you'd prefer, but I'd rather keep this
  one scoped to the Fixes: target.

Cheers.

