Return-Path: <netdev+bounces-21985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D2C7658AA
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 18:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C0C7282382
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 16:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACAAF19884;
	Thu, 27 Jul 2023 16:30:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1981CA0E
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 16:30:09 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E16198A
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 09:30:07 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5840614b13cso18564387b3.0
        for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 09:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690475407; x=1691080207;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vSnIOQEtd8JLvzjpnMN8jpiUA8hMJ626P2zArmKB0JI=;
        b=nzvaibgkQNT9NREP+Qxlz/CeIFCfoeGtnZusVpcfot1eVS0b+X1FhdQ9YiMMvjg2ZC
         8LdCId4RY/Ndfy2m1bNbWNaqek3F/4OBMrTLEgz8ZTavRmvhftdqkZhEQz8Lb6rhNZb3
         6R1nuCbSmJ93KUctknvCq46Sdfp/mWSEwH2vrwWtTk1XsRCS8SFLKGsM82Ljet09dJ7l
         pJjYVUnSByeBkF4qwSTNu40YEEscagunMTfZNCRpDKCwg008CMIm1xBYpyBgh+egFwnD
         KCntWtBHBOYrlG6P2gdJai/kvt9t1uIlOkWzd+h8hMmWw5tGVEVZZsqz09ivY9BrZxvf
         FMww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690475407; x=1691080207;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vSnIOQEtd8JLvzjpnMN8jpiUA8hMJ626P2zArmKB0JI=;
        b=fhyjl+/70pbLyBpHD4UKfZS8g3NZaE3Mivzz1y2z68ky7uvPfydyc6RAKx1msi0n3u
         rlOLKB8JfFAhuQLHl2N2mRLr1aqn84g/HnSBBSmPa8iEkp3rYxagq8pTH67T+iDr9tR8
         d5HzIOo+J1/9y0jxtSI3T63LgUiwdAbN4akLeqenjLd+ZY7mwux4KMVa6v0pReL3pXXt
         Y3imXJtJg/9TGXbhNcDKB2xvXkVge5GQrtciKN43S2BBhEveOmngm+yn7pjfRDxsJQOm
         UBp7r+y5zJaS31fDEXKAUa6mCjgqMafCakhUjoe4YAmeEGSld7Zg1oY8dFkaeOkkK6sv
         9YTA==
X-Gm-Message-State: ABy/qLbsxu/4szV7KwZONu5gI/yxZnDCb17C9X1qmafDaByKxxKwQuuf
	ZlSx/Ft2WeUmdmJoVKgVEatxFRqb81w/lvzNvylL5pSnoVJgborH0LKwNQBykAEiHQyp68zmjY1
	HmrZFr/qR5yn9BoicIp/XegN9OqK7Ri7+/fLiaxlEOxb56AuTUSl7Jw==
X-Google-Smtp-Source: APBJJlF1dXEWx050bfGbzAjA8LNXyteb6sLhECKQB11b8Z1gB6N6BcxUvLQhBNvULoyhoa2dkjEzTdA=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a81:b648:0:b0:56c:ed45:442c with SMTP id
 h8-20020a81b648000000b0056ced45442cmr42537ywk.5.1690475407176; Thu, 27 Jul
 2023 09:30:07 -0700 (PDT)
Date: Thu, 27 Jul 2023 09:29:59 -0700
In-Reply-To: <20230727163001.3952878-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230727163001.3952878-1-sdf@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230727163001.3952878-3-sdf@google.com>
Subject: [PATCH net-next v2 2/4] ynl: mark max/mask as private for kdoc
From: Stanislav Fomichev <sdf@google.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Simon mentioned in another thread that it makes kdoc happy
and Jakub confirms that commit e27cb89a22ad ("scripts: kernel-doc: support
private / public marking for enums") actually added the needed
support.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/net/ynl/ynl-gen-c.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 71c5e79e877f..650be9b8b693 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -2125,6 +2125,7 @@ _C_KW = {
 
             if const.get('render-max', False):
                 cw.nl()
+                cw.p('/* private: */')
                 if const['type'] == 'flags':
                     max_name = c_upper(name_pfx + 'mask')
                     max_val = f' = {enum.get_mask()},'
-- 
2.41.0.487.g6d72f3e995-goog


