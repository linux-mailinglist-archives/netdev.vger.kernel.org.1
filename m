Return-Path: <netdev+bounces-254214-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEOxFz3zeWnT1AEAu9opvQ
	(envelope-from <netdev+bounces-254214-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 12:30:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 65329A06F9
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 12:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CEF2E3008234
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 11:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6F334D4FE;
	Wed, 28 Jan 2026 11:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="NU+YQ0gw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-10698.protonmail.ch (mail-10698.protonmail.ch [79.135.106.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD34F327BE7
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 11:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769599573; cv=none; b=Q5PzqKHi6m/9vau77sAVOEOFrEoIL50g8xm65mjp1MTobb3TJj88PeEXOyzhNKw542cL0VEcqFfOopoMGuMD6KDZaDeguw4UX7v8tZxuoIQaP13E8c5GEyrIqpTI3j1KxYaPCVsm/xHz5dWokhQ/NZlQQuQxMrVPRBX1HryYk2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769599573; c=relaxed/simple;
	bh=Va9OymS6I62hmBAGNUTB18fS/BXPW/oP1CxxsmBqxdw=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=nAaLmCpU3LTFbgt5nqzU4lHOe9VRNY0bXnABqjmPh4dyft05Jrb7P3jb1yEqnEImOzM10N9EgkdxmTLBO0hlBQJTape/nfMUGxJ/Neb0k/A8anNDHf/uvo/bVdwtD7jmR7x/p1glNMuMEgjRKhcvFl9j5ZubCl4pRnYMow28mx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=NU+YQ0gw; arc=none smtp.client-ip=79.135.106.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1769599561; x=1769858761;
	bh=/0yAKNGguHhvwY57MgQS48RwpAmQAERfAjPDBJbwlQU=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=NU+YQ0gwAHxNA3Zn3ybNPFkIGrT5qlrx0luvDeivu/K1HZcwNQ0ViTj5HyQYQvKw6
	 hRLesXpq76O9lfzdtoJ2O/mb9J9Kh2aVfUZ1eThnA/1GQMaOsqICKMGEbwa5mAxEJS
	 4GWhPrl0XJcWbIDPt6pxg7nRnzB6CPQzoH6ZM6qKDVRjxP6eQe0KUDFDm3IAsbQmUd
	 UgfZp1peVGq073sen0G6o/sHj3fTdtUlwNUAVoBixuS8txtHmy6JRbJGlpFDsmg+NJ
	 D2mPDYNshoZDMv0eNioShD7fT2lIOi+zIco/lEPAaSQV8HfDyx1UROhyRyjaNldvDe
	 S1dDJsPpYKzKA==
Date: Wed, 28 Jan 2026 11:25:57 +0000
To: Linux Networking <netdev@vger.kernel.org>
From: Turritopsis Dohrnii Teo En Ming <teo.en.ming@protonmail.com>
Cc: "ceo@teo-en-ming-corp.com" <ceo@teo-en-ming-corp.com>
Subject: Finally managed to get rsync script working after working on it for more than 7 hours since 1.30 AM on 28 Jan 2026 Wednesday
Message-ID: <aFkDZy9fzBmqwpNggSLUGICQ1zv0HHho57ZpJexFyvgwRkWUdJZxoqyzFuI03CprptRBp1Ht1rN98zKMAW5rgajQ5StJ-xtPAfhPXu4dLnw=@protonmail.com>
Feedback-ID: 39510961:user:proton
X-Pm-Message-ID: 95ca48af27b2d451e43cc3edfb04baf9f5805dbe
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[protonmail.com,quarantine];
	R_DKIM_ALLOW(-0.20)[protonmail.com:s=protonmail3];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_FROM(0.00)[protonmail.com];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-254214-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[teo.en.ming@protonmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[protonmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,rsync_script.sh:url,protonmail.com:mid,protonmail.com:dkim]
X-Rspamd-Queue-Id: 65329A06F9
X-Rspamd-Action: no action

Subject: Finally managed to get rsync script working after working on it fo=
r more than 7 hours since 1.30 AM on 28 Jan 2026 Wednesday

Good day from Singapore,

I have finally managed to get rsync script working after working on it for =
more than 7 hours since 1.30 AM on 28 Jan 2026 Wednesday.

The old Synology DS713+ NAS was backed up to USB external harddisk using Hy=
per Backup.

The Hyper Backup on the USB external harddisk was fully restored on the new=
 Synology DS1522+ NAS at 1.30 AM on 28 Jan 2026 Wednesday.

Since 1.30 AM in the morning, I have been working for more than 7 hours to =
get the rsync script working, all throughout the night.

rsync daemon keeps failing with errors, so I had no choice but to turn to r=
sync SSH.

Before running rsync SSH, I need to get passwordless SSH login working firs=
t.

1=EF=B8=8F=E2=83=A3 Generate an SSH key on DS713+ (client)

ssh-keygen -t rsa -b 4096

Press Enter to accept the default path: /var/services/homes/rsyncuser/.ssh/=
id_rsa

Press Enter again for no passphrase (needed for automation)

This creates:

/var/services/homes/rsyncuser/.ssh/id_rsa       =E2=86=90 private key (keep=
 secret!)
/var/services/homes/rsyncuser/.ssh/id_rsa.pub   =E2=86=90 public key

2=EF=B8=8F=E2=83=A3 Copy the public key to DS1522+ (server) manually

SSH into DS1522+ as rsyncuser

mkdir -p ~/.ssh

chmod 700 ~/.ssh

On DS713+, print your public key:

cat /var/services/homes/rsyncuser/.ssh/id_rsa.pub

---public key snipped---

On DS1522+, append it to authorized_keys:

vi ~/.ssh/authorized_keys

chmod 600 ~/.ssh/authorized_keys

3=EF=B8=8F=E2=83=A3 Test passwordless login

ssh rsyncuser@192.168.0.101

The authenticity of host '192.168.0.101 (192.168.0.101)' can't be establish=
ed.
ECDSA key fingerprint is ---snipped---
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '192.168.0.101' (ECDSA) to the list of known hos=
ts.
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@         WARNING: UNPROTECTED PRIVATE KEY FILE!          @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
Permissions 0777 for '/var/services/homes/rsyncuser/.ssh/id_rsa' are too op=
en.
It is required that your private key files are NOT accessible by others.
This private key will be ignored.
Load key "/var/services/homes/rsyncuser/.ssh/id_rsa": bad permissions
rsyncuser@192.168.0.101's password:

On DS713+:

chmod 700 /var/services/homes/rsyncuser/.ssh

chmod 600 /var/services/homes/rsyncuser/.ssh/id_rsa

chmod 644 /var/services/homes/rsyncuser/.ssh/id_rsa.pub

Passwordless ssh login is now successful.

Test rsync for 1 shared folder

1st test:

nohup rsync -aHAX --numeric-ids \
  --partial --info=3Dprogress2,stats2,name \
  --outbuf=3DL \
  -e "ssh -o ServerAliveInterval=3D30 -o ServerAliveCountMax=3D20" \
  "/volume1/1 Sales/" \
  "rsyncuser@192.168.0.101:/volume1/1 Sales/" \
  >> /volume1/rsync_1_Sales.log 2>&1 &

2nd test:

nohup rsync -aHAX --numeric-ids \
  --partial --progress --verbose \
  --outbuf=3DL \
  -e "ssh -o ServerAliveInterval=3D30 -o ServerAliveCountMax=3D20" \
  "/volume1/1 Sales/" \
  "rsyncuser@192.168.0.101:/volume1/1 Sales/" \
  >> /volume1/rsync_1_Sales.log 2>&1 &

No output for above rsync runs.

Test rsync for small folder "web"

rsync -av --progress \
  -e "ssh -o ServerAliveInterval=3D30 -o ServerAliveCountMax=3D20" \
  "/volume1/web/" \
  "rsyncuser@192.168.0.101:/volume1/web/"

Result:

sending incremental file list
rsync: opendir "/volume1/web/web_images" failed: Permission denied (13)
./
@eaDir/
@eaDir/@tmp/

sent 356 bytes  received 29 bytes  256.67 bytes/sec
total size is 2,310  speedup is 6.00
rsync error: some files/attrs were not transferred (see previous errors) (c=
ode 23) at main.c(1462) [sender=3D3.1.2]


Test rsync again with exclude eaDir

rsync -av --progress \
  --exclude=3D'@eaDir/' \
  -e "ssh -o ServerAliveInterval=3D30 -o ServerAliveCountMax=3D20" \
  "/volume1/web/" \
  "rsyncuser@192.168.0.101:/volume1/web/"

Result:

sending incremental file list
rsync: opendir "/volume1/web/web_images" failed: Permission denied (13)

sent 275 bytes  received 14 bytes  192.67 bytes/sec
total size is 2,310  speedup is 7.99
rsync error: some files/attrs were not transferred (see previous errors) (c=
ode 23) at main.c(1462) [sender=3D3.1.2]

=E2=9C=85 CORRECT FIX (safe, Synology-approved)

You need to re-apply and enforce ACL inheritance on the source NAS (DS713+)=
.

sudo synoacltool -add /volume1/web rsyncuser:allow:rwx

Result:

(synoacltool.c, 253)Unknown error


sudo synoacltool -enforce-inherit /volume1/web

rsyncuser@DiskStation:~/.ssh$ sudo -u rsyncuser ls /volume1/web/web_images
ls: cannot open directory '/volume1/web/web_images': Permission denied

=E2=9C=85 Working approach: run rsync as root via SSH

Since your goal is migration to DS1522+, the easiest solution that actually=
 works on DS713+ is:

Use root on DS713+ as the source

Use SSH rsync with passwordless keys for root

Exclude @eaDir

This avoids all ACL problems because root can read every folder, including =
legacy ACL-protected subfolders.

On DS713+:

sudo -i
ssh-keygen -t rsa

Generating public/private rsa key pair.
Enter file in which to save the key (/root/.ssh/id_rsa):
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /root/.ssh/id_rsa
Your public key has been saved in /root/.ssh/id_rsa.pub
The key fingerprint is:
---snipped---
The key's randomart image is:
+---[RSA 3072]----+
---snipped---
+----[SHA256]-----+

cat /root/.ssh/id_rsa.pub

---public key snipped---

On DS1522+:

echo "---public key snipped---" >> /var/services/homes/rsyncuser/.ssh/autho=
rized_keys


chmod 600 /var/services/homes/rsyncuser/.ssh/authorized_keys
chown -R rsyncuser:users /var/services/homes/rsyncuser/.ssh

Now root on DS713+ =E2=86=92 rsyncuser on DS1522+ is passwordless.

Test rsync again.

rsync -aAX --numeric-ids --partial \
  --exclude=3D'@eaDir/' \
  -e "ssh -o ServerAliveInterval=3D30 -o ServerAliveCountMax=3D20" \
  "/volume1/web/" \
  "rsyncuser@192.168.0.101:/volume1/web/" \
  >> /volume1/rsync_web.log=20

rsync: failed to modify permissions on "/volume1/web/intranet": Operation n=
ot permitted (1)
rsync: rsync_xal_set: set_xattr_syno_acl(""/volume1/web/."","user.rsync.syn=
oacl") failed: Permission denied (13)
rsync error: some files/attrs were not transferred (see previous errors) (c=
ode 23) at main.c(1462) [sender=3D3.1.2]

Test rsync again:

rsync -a --numeric-ids --partial \
  --exclude=3D'@eaDir/' \
  --no-acls --no-xattrs \
  -e "ssh -o ServerAliveInterval=3D30 -o ServerAliveCountMax=3D20" \
  "/volume1/web/" \
  "rsyncuser@192.168.0.101:/volume1/web/" \
  >> /volume1/rsync_web.log=20

rsync: failed to set permissions on "/volume1/web/.htaccess": Operation not=
 permitted (1)
rsync: failed to set permissions on "/volume1/web/index.html": Operation no=
t permitted (1)
rsync: failed to set permissions on "/volume1/web/intranet": Operation not =
permitted (1)
rsync: failed to modify permissions on "/volume1/web/intranet": Operation n=
ot permitted (1)
rsync: failed to set permissions on "/volume1/web/intranet/***_index.php": =
Operation not permitted (1)
rsync: failed to set permissions on "/volume1/web/intranet/index.php": Oper=
ation not permitted (1)
rsync error: some files/attrs were not transferred (see previous errors) (c=
ode 23) at main.c(1462) [sender=3D3.1.2]

Test rsync again:

rsync -av --numeric-ids --partial \
  --exclude=3D'@eaDir/' \
  --chmod=3Dugo=3DrwX \
  --no-acls --no-xattrs \
  -e "ssh -o ServerAliveInterval=3D30 -o ServerAliveCountMax=3D20" \
  "/volume1/web/" \
  "rsyncuser@192.168.0.101:/volume1/web/" \
  >> /volume1/rsync_web.log

rsync: failed to set permissions on "/volume1/web/.htaccess": Operation not=
 permitted (1)
rsync: failed to set permissions on "/volume1/web/intranet/***_index.php": =
Operation not permitted (1)
rsync: failed to set permissions on "/volume1/web/intranet/index.php": Oper=
ation not permitted (1)
rsync: failed to set permissions on "/volume1/web/web_images": Operation no=
t permitted (1)
rsync: failed to set permissions on "/volume1/web/web_images/bg.png": Opera=
tion not permitted (1)
rsync: failed to set permissions on "/volume1/web/web_images/icon.png": Ope=
ration not permitted (1)
rsync error: some files/attrs were not transferred (see previous errors) (c=
ode 23) at main.c(1462) [sender=3D3.1.2]

Test rsync again:

rsync -rltDv --progress \
  --exclude=3D'@eaDir/' \
  --no-perms --no-owner --no-group --no-acls --no-xattrs \
  -e "ssh -o ServerAliveInterval=3D30 -o ServerAliveCountMax=3D20" \
  "/volume1/web/" \
  "rsyncuser@192.168.0.101:/volume1/web/" \
  >> /volume1/rsync_web.log

Output:

sending incremental file list

sent 280 bytes  received 14 bytes  196.00 bytes/sec
total size is 233,274  speedup is 793.45

New rsync script:

vi rsync_script.sh

#!/bin/bash
# DS713+ -> DS1522+ migration via rsync over SSH
# All shared folders in a loop, passwordless SSH, background-safe

# Target NAS and user
TARGET_USER=3D"rsyncuser"
TARGET_HOST=3D"192.168.0.101"

# Shared folders to migrate
FOLDERS=3D(
"1 Sales"
"2 OPERATIONS"
"3 Admin"
"4 ISO 9001"
"5 Finance"
"6 IT"
"7 Volume_1"
"8"
"8 SynologyLog"
"Completed Projects"
"Disk 2"
"docker"
"OSV and LLP"
"Volume_2"
"web"
"web_packages"
)

# Base log folder on source NAS
LOGDIR=3D"/volume1/rsync_logs"
mkdir -p "$LOGDIR"

# Loop over folders
for F in "${FOLDERS[@]}"; do
    # Escape spaces in folder name for rsync destination
    DEST_FOLDER=3D"$F"

    echo "Starting rsync for folder: $F"

    nohup rsync -rltDv --progress \
        --exclude=3D'@eaDir/' \
        --no-perms --no-owner --no-group --no-acls --no-xattrs \
        -e "ssh -o ServerAliveInterval=3D30 -o ServerAliveCountMax=3D20" \
        "/volume1/$F/" \
        "$TARGET_USER@$TARGET_HOST:/volume1/$DEST_FOLDER/" \
        >> "$LOGDIR/rsync_$(echo $F | tr ' ' '_').log" 2>&1 &

done

echo "All rsync jobs started in background. Logs are in $LOGDIR"

End of script.



chmod +x rsync_script.sh

/root/rsync_script.sh

Output:

root@DiskStation:/volume1/rsync_logs# tail -f rsync_1_Sales.log
kex_exchange_identification: Connection closed by remote host
rsync error: unexplained error (code 255) at io.c(254) [sender=3D3.1.2]

Test another script:

#!/bin/bash
# Sequential background rsync for Synology migration
# Source: DS713+, Target: DS1522+ (rsyncuser)
# One folder at a time to avoid SSH session limits

TARGET_USER=3D"rsyncuser"
TARGET_HOST=3D"192.168.0.101"

FOLDERS=3D(
"1 Sales"
"2 OPERATIONS"
"3 Admin"
"4 ISO 9001"
"5 Finance"
"6 IT"
"7 Volume_1"
"8"
"8 SynologyLog"
"Completed Projects"
"Disk 2"
"docker"
"OSV and LLP"
"Volume_2"
"web"
"web_packages"
)

LOGDIR=3D"/volume1/rsync_logs"
mkdir -p "$LOGDIR"

for F in "${FOLDERS[@]}"; do
    LOGFILE=3D"$LOGDIR/rsync_$(echo $F | tr ' ' '_').log"
    echo "=3D=3D=3D=3D=3D Starting rsync for folder: $F at $(date) =3D=3D=
=3D=3D=3D" >> "$LOGFILE"

    # Run rsync sequentially but in background via nohup
    nohup rsync -rltDv --progress \
        --exclude=3D'@eaDir/' \
        --no-perms --no-owner --no-group --no-acls --no-xattrs \
        -e "ssh -o ServerAliveInterval=3D30 -o ServerAliveCountMax=3D20" \
        "/volume1/$F/" \
        "$TARGET_USER@$TARGET_HOST:/volume1/$F/" \
        >> "$LOGFILE" 2>&1

    echo "=3D=3D=3D=3D=3D Completed rsync for folder: $F at $(date) =3D=3D=
=3D=3D=3D" >> "$LOGFILE"
done

echo "All rsync folders queued sequentially in nohup. Logs in $LOGDIR"

End of script

nohup /root/rsync_script.sh &

Output:

=3D=3D=3D=3D=3D Starting rsync for folder: 1 Sales at Wed Jan 28 12:31:35 +=
08 2026 =3D=3D=3D=3D=3D
sending incremental file list
rsync: [sender] write error: Broken pipe (32)
rsync error: error in socket IO (code 10) at io.c(871) [sender=3D3.1.2]
=3D=3D=3D=3D=3D Completed rsync for folder: 1 Sales at Wed Jan 28 12:31:37 =
+08 2026 =3D=3D=3D=3D=3D

Testing another script:

#!/bin/bash
# DS713+ -> DS1522+ migration via SSH rsync
# Sequentially process 16 shared folders, per-folder logging
# Skip ACLs/xattrs to avoid permission errors
# Exclude @eaDir

# Target NAS and user
TARGET_USER=3D"rsyncuser"
TARGET_HOST=3D"192.168.0.101"

# Shared folders to migrate
FOLDERS=3D(
"1 Sales"
"2 OPERATIONS"
"3 Admin"
"4 ISO 9001"
"5 Finance"
"6 IT"
"7 Volume_1"
"8"
"8 SynologyLog"
"Completed Projects"
"Disk 2"
"docker"
"OSV and LLP"
"Volume_2"
"web"
"web_packages"
)

# Base log folder on source NAS
LOGDIR=3D"/volume1/rsync_logs"
mkdir -p "$LOGDIR"

# Loop through folders sequentially
for F in "${FOLDERS[@]}"; do
    LOGFILE=3D"$LOGDIR/rsync_$(echo "$F" | tr ' ' '_').log"
    echo "=3D=3D=3D=3D=3D Starting rsync for folder: $F at $(date) =3D=3D=
=3D=3D=3D" >> "$LOGFILE"

    rsync -rltDv --progress \
        --exclude=3D'@eaDir/' \
        --no-perms --no-owner --no-group --no-acls --no-xattrs \
        -e "ssh -o ServerAliveInterval=3D30 -o ServerAliveCountMax=3D20" \
        "/volume1/$F/" \
        "$TARGET_USER@$TARGET_HOST:/volume1/$F/" \
        >> "$LOGFILE" 2>&1

    echo "=3D=3D=3D=3D=3D Completed rsync for folder: $F at $(date) =3D=3D=
=3D=3D=3D" >> "$LOGFILE"
done

echo "All folders have been processed sequentially. Logs are in $LOGDIR"




nohup /root/rsync_script.sh > /volume1/rsync_master.log 2>&1 &

Output:

=3D=3D=3D=3D=3D Starting rsync for folder: 1 Sales at Wed Jan 28 12:37:26 +=
08 2026 =3D=3D=3D=3D=3D
sending incremental file list
rsync: [sender] write error: Broken pipe (32)
rsync error: error in socket IO (code 10) at io.c(871) [sender=3D3.1.2]
=3D=3D=3D=3D=3D Completed rsync for folder: 1 Sales at Wed Jan 28 12:37:27 =
+08 2026 =3D=3D=3D=3D=3D




GRAND FINAL WORKING RSYNC SCRIPT - CONFIRMED AND TESTED TO BE WORKING! - AS=
 AT 28 JAN 2026 Wednesday 1.36 PM
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

#!/bin/bash
# Bulletproof Synology migration script: DS713+ -> DS1522+
# Sequential SSH rsync for 16 shared folders
# Handles spaces, retries, logs, #recycle excluded

# ----------------------------
# Configuration
# ----------------------------
TARGET_USER=3D"rsyncuser"
TARGET_HOST=3D"192.168.0.101"
BW_LIMIT=3D3000          # KB/s, adjust as needed
MAX_RETRIES=3D3
LOGDIR=3D"/volume1/rsync_logs"
mkdir -p "$LOGDIR"

# List of shared folders to migrate
FOLDERS=3D(
"1 Sales"
"2 OPERATIONS"
"3 Admin"
"4 ISO 9001"
"5 Finance"
"6 IT"
"7 Volume_1"
"8"
"8 SynologyLog"
"Completed Projects"
"Disk 2"
"docker"
"OSV and LLP"
"Volume_2"
"web"
"web_packages"
)

# ----------------------------
# Pre-create all destination folders on DS1522+
# ----------------------------
echo "Creating all target folders on $TARGET_HOST..."
for F in "${FOLDERS[@]}"; do
    ssh "$TARGET_USER@$TARGET_HOST" "mkdir -p '/volume1/$F'"
done
echo "All destination folders created."

# ----------------------------
# Migration loop
# ----------------------------
for F in "${FOLDERS[@]}"; do
    LOGFILE=3D"$LOGDIR/rsync_$(echo "$F" | tr ' ' '_').log"
    echo "=3D=3D=3D=3D=3D Starting rsync for folder: $F at $(date) =3D=3D=
=3D=3D=3D" >> "$LOGFILE"

    RETRY_COUNT=3D0
    SUCCESS=3D0

    while [ $RETRY_COUNT -lt $MAX_RETRIES ]; do
        rsync -rltDv --progress \
            --exclude=3D'@eaDir/' \
            --exclude=3D'#recycle/' \
            --no-perms --no-owner --no-group --no-acls --no-xattrs \
            --bwlimit=3D$BW_LIMIT \
            -e "ssh -o ServerAliveInterval=3D15 -o ServerAliveCountMax=3D10=
 -o TCPKeepAlive=3Dyes" \
            "/volume1/$F/" \
            "$TARGET_USER@$TARGET_HOST:'/volume1/$F/'" \
            >> "$LOGFILE" 2>&1

        if [ $? -eq 0 ]; then
            SUCCESS=3D1
            echo "=3D=3D=3D=3D=3D Completed rsync for folder: $F at $(date)=
 SUCCESS =3D=3D=3D=3D=3D" >> "$LOGFILE"
            break
        else
            RETRY_COUNT=3D$((RETRY_COUNT+1))
            echo "=3D=3D=3D=3D=3D rsync FAILED for folder: $F, retry $RETRY=
_COUNT/$MAX_RETRIES at $(date) =3D=3D=3D=3D=3D" >> "$LOGFILE"
            sleep 5
        fi
    done

    if [ $SUCCESS -eq 0 ]; then
        echo "=3D=3D=3D=3D=3D Folder $F FAILED after $MAX_RETRIES retries a=
t $(date) =3D=3D=3D=3D=3D" >> "$LOGFILE"
    fi
done

echo "All folders processed sequentially. Logs are in $LOGDIR"

End of script.


chmod +x rsync_script.sh

nohup /root/rsync_script.sh > /volume1/rsync_master.log 2>&1 &

Thank you.

Regards,

Mr. Turritopsis Dohrnii Teo En Ming
Extremely Democratic People's Republic of Singapore
28 Jan 2026 Wednesday 7.24 pm Singapore Time





