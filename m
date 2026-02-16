Return-Path: <netdev+bounces-258849-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOV4F+HnkmlSzwEAu9opvQ
	(envelope-from <netdev+bounces-258849-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 10:48:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F31BE1420FB
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 10:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 65FE83003813
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 09:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D23284B25;
	Mon, 16 Feb 2026 09:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LfhBhUta"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349142798E8
	for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 09:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771235294; cv=none; b=WWu+kAC+3s/FoaaNHSPyBB0Xz9TvL3QK5RDVpm5kc4tceGLKWcyXR4Zmy0u5P8dxdOYq+euZcBxGmw11VYvU0R6KoB3vBVTyFxGHQ8SIFss4VkCGEzHzIfqDJptSCT/rfuiA9gwD+GdjP5cffHNI9GEweSD8KgQS/xW9z8hExPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771235294; c=relaxed/simple;
	bh=KwzAJjfZkRyfRk44kT/xWpokGe15+QPROcE7nsjrVuU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=k20T1e44gw2WW0Ehe1x2QG5Rgo7r6h0aIgMJg7I8Fl+z//+lmRB4EySDKCO6pfuwglK1qkR99r6x2RaDycL2zQN7NXRTs+zJDUJPFhTVbixiQ3wLlHi9EdqLxKusiKQTSO0NtlXv3BCQk7mReC7pBDp0hNTtYaN3r2YoewKtbRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LfhBhUta; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-823075fed75so1671963b3a.1
        for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 01:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771235292; x=1771840092; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sa5mFJx9LXvAEAxLjT/ZZ47KVBlink7O7vxh2GfNNnQ=;
        b=LfhBhUtacMnJFKqPjQX94WX1osVJmNemfhX+1yPoqOjz4fZGBTEQ6/EruAfPh+1AJB
         G2gUuSuHOqeYtiqadXqn/6kwoKyrFOaFJAgByfpAuawrk3Cut8aCsDmYEfSzhr5n0m37
         KBZ3UsuAxo3Kq9osJ9iz0sBtkKLdQujUPOaSESylUo9sIlHO/D2q2jtxN9D/yD+sXXum
         /cmqC55vAF5fLFXesPgAWzzf1xCfxbdUedZYTZ8etblkwohQOlxw7K6MS2ynPtjuDY0G
         1NnkZ3lvM84UO9yukwpHTOh+5L+BCLsogRCuIAZkIRL602HoXqR1AqotVmpkaIjOUaI1
         uaFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771235292; x=1771840092;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sa5mFJx9LXvAEAxLjT/ZZ47KVBlink7O7vxh2GfNNnQ=;
        b=OZ47/sElSxDJeF3vpFJBBLcnD08swYlAwyr4SCVRrwlb033KHt1afXPaMy0Q330N4t
         CqRyelwa4fgXsQSfGYuXnESzeeehlvLIk3ClbHPsasxpy5xf71BkG4y4Y/j8Jiu9Xp4H
         mXMBLlsmhlPGZ6z/YcSEmSwafDYOhA6g4E0LvwmS6Czk1G270PAM3/cr9eNXQj+Oim7O
         aLFycdXLCpOkQWwvoxd9QKTqidSwv9RX2lN3g+HKpAmAJDtRWkLbA8iQmFXIZaygb9SV
         u+Ojf2tpGGlzcaTqEJkwyS6c4MuNGHZd+sFkzJUpJT4+2+tOuwPXkkcmGvxE4hM+hmIZ
         CUEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTy8Q0jfeZz3fkZUBJ+JK090hTD/5fp3nJ+DV+pr303qEg34HrYuC1tk6OXzl3BMpe2DzrrCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN9ab5c73d/DkmaOBg8KuUiDHuVfXzCN3Nx1a/la8QtXMkzJhy
	tCNFCWl3rkDwHBN1h4ftNz5m63Hv6P/1FLv0MxuK8CpwthIFFqETI5ni
X-Gm-Gg: AZuq6aJ7rbP9XKGI6Kbe4zHQHrrY94ArL9Zc9xE8qHgXSY49e9QpRmAOH8L2Rq6YRky
	R0/C8Ye0aWjI/y+CXTxStoNrRZziZZclhOXN6KUqTyPJM7DWB3T6G45TV8V2PxEULP8+LkL5xKh
	RSk1dT2heMZ79sDBAbyiVmD4Fgy/axDrGMiougFugK9vWDTTXhW5FnJ6tmf64iIRsk5sVS80rPW
	3K8Ue3Nq8bS39KQlteMQ3zGPt8XbJ0W/k5d0KWSaXQRyZlIKETrQbsBMJCNPwZ3Up4YEvQ3h6nm
	x5JMpdXJypR40wmWa3BEobF8bYz55RbJ6kMY+IhYG+6mfvUC1F0/N1C364kN9sNjh2JeVLSnOjn
	mzBF49aUMcEC60MCbHSTtjLYi2nhY328k6+V3tETcd0KGDTVvD/y7i35A6/U95NC7VneThl2c+h
	J64Ho73e19p6GDO4R/u7U4xs2K7EMsLhOEjBO9ZhKLBw==
X-Received: by 2002:a05:6a00:3986:b0:818:1e8c:a513 with SMTP id d2e1a72fcca58-824d5e1de15mr7722795b3a.17.1771235292506;
        Mon, 16 Feb 2026 01:48:12 -0800 (PST)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6b69ee6sm9789602b3a.32.2026.02.16.01.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 01:48:12 -0800 (PST)
Date: Mon, 16 Feb 2026 18:48:08 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org
Cc: sd@queasysnail.net, nate.karstens@garmin.com, linux@treblig.org,
	Julia.Lawall@inria.fr, netdev@vger.kernel.org, imv4bel@gmail.com
Subject: [PATCH] strparser: Use worker disable API instead of cancellation in
 strp_done()
Message-ID: <aZLn2Faeg1FB7XOf@v4bel>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[queasysnail.net,garmin.com,treblig.org,inria.fr,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-258849-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imv4bel@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F31BE1420FB
X-Rspamd-Action: no action

When strp_stop() and strp_done() are called without holding lock_sock(), 
they can race with worker-scheduling paths such as the Delayed ACK handler 
and ksoftirqd.
Specifically, after cancel_delayed_work_sync() and cancel_work_sync() are 
invoked from strp_done(), the workers may still be scheduled.
As a result, the workers may dereference freed objects.

To prevent these races, the cancellation APIs are replaced with 
worker-disabling APIs.

Fixes: 829385f08ae9 ("strparser: Use delayed work instead of timer for msg timeout")
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 net/strparser/strparser.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/strparser/strparser.c b/net/strparser/strparser.c
index fe0e76fdd1f1..15cd9cadbd1a 100644
--- a/net/strparser/strparser.c
+++ b/net/strparser/strparser.c
@@ -503,8 +503,8 @@ void strp_done(struct strparser *strp)
 {
 	WARN_ON(!strp->stopped);
 
-	cancel_delayed_work_sync(&strp->msg_timer_work);
-	cancel_work_sync(&strp->work);
+	disable_delayed_work_sync(&strp->msg_timer_work);
+	disable_work_sync(&strp->work);
 
 	if (strp->skb_head) {
 		kfree_skb(strp->skb_head);
-- 
2.43.0

---
Dear,

The following is a simplified scenario illustrating how each race can occur. Since espintcp_close() does not hold lock_sock(), the race is possible.
Although cancel_work_sync(&strp->work) does not appear to be easy to trigger in practice here, it still seems better to fix it as well.
```
                 cpu0                                cpu1

espintcp_close()
                                         espintcp_data_ready()
                                           if (unlikely(strp->stopped)) return;
  strp_stop()
    strp->stopped = 1;
  strp_done()
    cancel_delayed_work_sync(&strp->msg_timer_work);
                                           strp_data_ready()
                                             strp_read_sock()
                                               tcp_read_sock()
                                                 __tcp_read_sock()
                                                   strp_recv()
                                                     __strp_recv()
                                                       strp_start_timer()
                                                         mod_delayed_work(strp_wq, &strp->msg_timer_work, timeo);  
```
```
                 cpu0                                cpu1

espintcp_close()
                                          sk->sk_data_ready()
                                            espintcp_data_ready()
                                              if (unlikely(strp->stopped)) return;
  strp_stop()
    strp->stopped = 1;
  strp_done()
    cancel_work_sync(&strp->work);
                                              if (strp_read_sock(strp) == -ENOMEM)
                                              queue_work()
```

Best regards,
Hyunwoo Kim

