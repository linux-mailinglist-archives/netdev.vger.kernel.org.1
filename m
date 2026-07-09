Return-Path: <netdev+bounces-306385-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LYTYM4kkUGrruAIAu9opvQ
	(envelope-from <netdev+bounces-306385-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 00:45:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3CA7361F1
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 00:45:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=purestorage.com header.s=google2022 header.b="Bl/HaY/B";
	dmarc=pass (policy=quarantine) header.from=purestorage.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306385-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306385-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8D35300E3AE
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 22:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3A72D877B;
	Thu,  9 Jul 2026 22:45:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC0A275AFD
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 22:45:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783637126; cv=none; b=N+ew/qo+mQrnma1eOAJo0FHPouiGRTweBSakfm0ZA/hUGag5DTUAgqwKdOT6b36dQMLnqZraRBmWx6HIPQfe0Jvb7GwXDCX+MDw7qZY4qn+Xb9vdTpT+W1QXOlA7BrA5RBY2wHP9BsqRm/SL4+7e/4ivAALAAXKdjv7sHBZcJfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783637126; c=relaxed/simple;
	bh=PGA51qcJl1AGeqefbdcJEocMVpVLsNqh/riRpqGi+mA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D8lshHvnFvbrGRECISfExh6VO1c91vkfzUJOy1KkQ9qsikuP+v9x+0ZAy7Cn8prSw9M4USkzwVIbk+VImIzG1J0TCHteIlx8b4bDa1aEeqBBQ0+MwgO1EH4HFtRxjEJcI4wzfnnSKLrE/2OovBHTEWVg5p0ptRo+B3Z2knDJ7Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Bl/HaY/B; arc=none smtp.client-ip=209.85.128.49
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-493c2b3dc8bso2313955e9.2
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 15:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1783637123; x=1784241923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WMldnSXgyQlbR/IpoLJ/1a+tMf+oUWb8mfZnHDZzdLw=;
        b=Bl/HaY/BVN1+AtWcAWSSkLzXhf1xUPqm2UryiH441BNKtctIwZWp2aRZivJlDZX8tc
         2mZh5GZ9UYo/00AHxEpzjma6ePmONabPuEF4WnjBvwnu3X7CzY06cLi+t2RdBVY9K6tk
         Zem6TBmCyVJJMGxLKd6cZbnUDf5INEJNoLkzG5GJSu3EE3YXzLredj2Ipc9u5AjJnuKt
         kgiqzRuhGzf8Bccs9ydo2H8sMlyHPh7syFqfpZ2/dIjosBlo5CKP+ONdZJB8hLnqr75Z
         YzwdLmuRuEuY9IAK+huFFTVzmyGrY6ad9hnbA/7GLo9dAA9+BQlaTgjC39C6XwHc2n44
         H+Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783637123; x=1784241923;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WMldnSXgyQlbR/IpoLJ/1a+tMf+oUWb8mfZnHDZzdLw=;
        b=OYd3VqHJI9q6FjXKkYJHKjkmChqjpuBCP+B6zQrJELx6wqA/qq0MFoWQjiTfCBjdRf
         r/MnIdkVxp0UHcwAJFU79F+OruXpDUSYRdFS6VVm9ExtdvIia//cEeirriVvVLgazbY6
         BuEaCYpHJEp1CwhcYLtti6PmD2klUvln0de6mx90xzqPefAwSozpBCzQ6L9caFWNHlX/
         hEcd3QYfpGMgEIwYHKlW9a3my66AUS1TIH660BTMMBuX7LuOpEBLbPNyOayNm6FfNb5q
         QTFez5ACIqolLS7Laa99YlzQvospg93vOPwYXzrKQqXzYTbkMQsYEnG6P/dY38dj+04y
         sBQQ==
X-Gm-Message-State: AOJu0Ywlyo8UBYGIxIiV5G/Gm5utAK/GMOFbYJVCXNxSfZQSMzJnD/FY
	QO19ZYuiajuW63RiWN88XvcfmUYBlxgf40ljy78700mTA3N+iQQwVl2q55BER0MLB72qEN7C9vs
	La80EO2LZd3MrLLjY5vBM2UUhcBCr/PksjimQ8cW5TtGBXf5eShmtFhev5m9WzmZK3Fz7ekrXXQ
	o/pmKTKvptzIWjZ68JGrCgFzAyLoYzrqFvYhNM/ww2Wfa72x4=
X-Gm-Gg: AfdE7clp9nepgrKD4lfqwl32BNkE1+blMlh9mPGzaMj5ZkSOlO74c5iS+DECAwqj8x3
	uSsUUQsg5Uq3XL1Jxv8Lk6N3mlJj8orhfrg9LzF7Wsn53Dyw/23A4XVjFhELL6YDlyW/QEZEl/e
	DsY4TsM3Bq7koCJyk+HNxgkj4cyg6JxClWo+00SLGsDPtLpWDTCQipT2UTUQhIaomEnTTuWapl7
	GmzTyowh30DReQM4LEu6Mnt0PcKqJUfzuVwv5D54PDcxZ66BJYcVFBTSx86sN9ia0L7Wa+B9g4J
	SvKybwLyrwr2VTOsn0v41VJOxcS8I9rzBfX/SaXPeNA0GzuKQekp5g+GbTjd3YGqPu/Uc5as0/g
	QOvyQQVVdE3C/prffHKhlu+oeyjZi7/rv0p44kEZ25pwGxjoqOk0Slh9c/htjrFAxlj8m6xZpWm
	dT5OfBBcxPYp9rdkvnCS6sySnLiEwaqUsmxlZBjB7hrAvM9Y/mM0gWKXDRutbCmlco0LFQUZP7t
	vHYACmOsw7Z9XuM8LplIVEQrudLg/aI2Vfr9ChXIJEMQ0+qLbSLgTZWyN6d0EgZm9u5wkMGJBky
	FAEBmoMi5tsSSKoIcUQpfPZqkAoqyDrhXA9hMpPn37u1Nw==
X-Received: by 2002:a05:600c:3e8e:b0:493:d26b:1575 with SMTP id 5b1f17b1804b1-493e69b0dbdmr87936935e9.27.1783637123255;
        Thu, 09 Jul 2026 15:45:23 -0700 (PDT)
Received: from dev-rjethwani.dev.purestorage.com ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-47a9de1e6ccsm54918142f8f.5.2026.07.09.15.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 15:45:22 -0700 (PDT)
From: Rishikesh Jethwani <rjethwani@purestorage.com>
To: netdev@vger.kernel.org
Cc: john.fastabend@gmail.com,
	kuba@kernel.org,
	sd@queasysnail.net,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	leon@kernel.org,
	nils.juenemann@gmail.com,
	Rishikesh Jethwani <rjethwani@purestorage.com>
Subject: [PATCH net 0/1] tls: device: push pending open record on splice EOF
Date: Thu,  9 Jul 2026 16:44:35 -0600
Message-Id: <20260709224436.1608993-1-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[purestorage.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[purestorage.com:s=google2022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,queasysnail.net,davemloft.net,redhat.com,google.com,purestorage.com];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306385-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[rjethwani@purestorage.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:john.fastabend@gmail.com,m:kuba@kernel.org,m:sd@queasysnail.net,m:davem@davemloft.net,m:pabeni@redhat.com,m:edumazet@google.com,m:leon@kernel.org,m:nils.juenemann@gmail.com,m:rjethwani@purestorage.com,m:johnfastabend@gmail.com,m:nilsjuenemann@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[purestorage.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rjethwani@purestorage.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1B3CA7361F1

Hi all,

  A kTLS socket with device (HW) TX offload can leave its final
  record unsent when sendfile(2) is called with count > bytes-
  remaining in the file and the connection is closed without a
  trailing write. fs/splice.c fires ->splice_eof on the socket in
  this case, and tls_device_splice_eof() pre-patch only pushed
  partially-sent records - a fully-assembled but still-open record
  stayed pending until the next write, which an abrupt close()
  never provides. TLS_SW is unaffected; tls_sw_splice_eof() already
  handles pending open records.

  Report and discussion:
  https://lore.kernel.org/netdev/CAMPsyauZ+jzG9AysO0FWv6ZY0kvCUpjX_U7o=oOjCuOQ87BCgg@mail.gmail.com/

Rishikesh

Rishikesh Jethwani (1):
  tls: device: push pending open record on splice EOF

 net/tls/tls_device.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
2.25.1


